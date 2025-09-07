-- /* ---- 💫 Project Management Configuration 💫 ---- */
-- Project detection and management

-- This file contains project-specific configurations
-- Main project plugin config is in plugins/project.lua

-- Project-specific settings
vim.api.nvim_create_autocmd("User", {
  pattern = "ProjectDetected",
  callback = function(event)
    local project_type = event.data.type or "unknown"
    
    -- Set project-specific configurations
    if project_type == "python" then
      vim.g.current_project_type = "python"
      -- Python project specific settings
    elseif project_type == "node" then
      vim.g.current_project_type = "node"
      -- Node.js project specific settings
    elseif project_type == "java" then
      vim.g.current_project_type = "java"
      -- Java project specific settings
    end
  end,
})

-- Custom project detection
local function detect_project_type()
  local cwd = vim.fn.getcwd()
  
  -- Python project detection
  if vim.fn.filereadable(cwd .. "/requirements.txt") == 1 or
     vim.fn.filereadable(cwd .. "/pyproject.toml") == 1 or
     vim.fn.filereadable(cwd .. "/setup.py") == 1 or
     vim.fn.isdirectory(cwd .. "/venv") == 1 or
     vim.fn.isdirectory(cwd .. "/.venv") == 1 then
    return "python"
  end
  
  -- Node.js project detection  
  if vim.fn.filereadable(cwd .. "/package.json") == 1 or
     vim.fn.isdirectory(cwd .. "/node_modules") == 1 then
    return "node"
  end
  
  -- Java project detection
  if vim.fn.filereadable(cwd .. "/pom.xml") == 1 or
     vim.fn.filereadable(cwd .. "/build.gradle") == 1 or
     vim.fn.isdirectory(cwd .. "/src/main/java") == 1 then
    return "java"
  end
  
  return "unknown"
end

-- Set project type on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local project_type = detect_project_type()
    vim.g.current_project_type = project_type
    
    -- Trigger project detected event
    vim.api.nvim_exec_autocmds("User", {
      pattern = "ProjectDetected",
      data = { type = project_type }
    })
  end,
})
