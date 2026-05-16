return {
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        lazy = false,
        config = function()
            local map = require("core.keymaps").map
            local promise = require("promise")
            local ufo = require("ufo")

            local function handle_fallback(err, bufnr, provider)
                if type(err) == "string" and err:match("UfoFallbackException") then
                    return ufo.getFolds(bufnr, provider)
                end

                return promise.reject(err)
            end

            local function chained_provider(bufnr)
                return ufo.getFolds(bufnr, "lsp"):catch(function(err)
                    return handle_fallback(err, bufnr, "treesitter")
                end):catch(function(err)
                    return handle_fallback(err, bufnr, "indent")
                end)
            end

            local function fold_virt_text_handler(virt_text, lnum, end_lnum, width, truncate)
                local new_virt_text = {}
                local prefix = " ... "
                local left_cap = ""
                local right_cap = ""
                local label = (" %d lines folded "):format(end_lnum - lnum + 1)
                local suffix = prefix .. left_cap .. label .. right_cap
                local suffix_width = vim.fn.strdisplaywidth(suffix)
                local target_width = width - suffix_width
                local current_width = 0

                for _, chunk in ipairs(virt_text) do
                    local text = chunk[1]
                    local hl_group = chunk[2]
                    local chunk_width = vim.fn.strdisplaywidth(text)

                    if target_width > current_width + chunk_width then
                        table.insert(new_virt_text, chunk)
                    else
                        text = truncate(text, target_width - current_width)
                        table.insert(new_virt_text, { text, hl_group })
                        break
                    end

                    current_width = current_width + chunk_width
                end

                table.insert(new_virt_text, { prefix, "Comment" })
                table.insert(new_virt_text, { left_cap, "UfoFoldLineCountEdge" })
                table.insert(new_virt_text, { label, "UfoFoldLineCount" })
                table.insert(new_virt_text, { right_cap, "UfoFoldLineCountEdge" })
                return new_virt_text
            end

            ufo.setup({
                fold_virt_text_handler = fold_virt_text_handler,
                provider_selector = function(_, _, buftype)
                    if buftype ~= "" then
                        return ""
                    end

                    return chained_provider
                end,
            })

            map("n", "<leader>zz", "za", "Fold: Toggle")
            map("n", "<leader>zo", "zo", "Fold: Open")
            map("n", "<leader>zc", "zc", "Fold: Close")
            map("n", "<leader>zO", ufo.openAllFolds, "Fold: Open All")
            map("n", "<leader>zC", ufo.closeAllFolds, "Fold: Close All")
            map("n", "<leader>zp", function()
                local winid = ufo.peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end, "Fold: Preview")

            map("n", "]z", ufo.goNextClosedFold, "Fold: Next closed fold")
            map("n", "[z", ufo.goPreviousClosedFold, "Fold: Previous closed fold")
            map("n", "zR", ufo.openAllFolds, "Fold: Open All")
            map("n", "zM", ufo.closeAllFolds, "Fold: Close All")
        end,
    },
}
