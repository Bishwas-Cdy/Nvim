-- /* ---- 💫 Enhanced Snippets Configuration 💫 ---- */
-- Complete snippets for all programming languages

return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "honza/vim-snippets",
  },
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node
    local d = ls.dynamic_node
    local sn = ls.snippet_node
    local fmt = require("luasnip.extras.fmt").fmt
    local rep = require("luasnip.extras").rep

    -- Load all snippet packs
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_snipmate").lazy_load()

    -- Custom Python snippets
    ls.add_snippets("python", {
      s("main", fmt([[
        if __name__ == "__main__":
            {}
      ]], { i(1, "main()") })),

      s("class", fmt([[
        class {}:
            """{}"""
            
            def __init__(self{}):
                {}
      ]], { i(1, "ClassName"), i(2, "Class description"), i(3), i(4, "pass") })),

      s("def", fmt([[
        def {}({}):
            """{}"""
            {}
      ]], { i(1, "function_name"), i(2), i(3, "Function description"), i(4, "pass") })),

      s("try", fmt([[
        try:
            {}
        except {} as e:
            {}
      ]], { i(1, "# code"), i(2, "Exception"), i(3, "print(f'Error: {e}')") })),

      s("import", fmt([[
        import {}
      ]], { i(1, "module") })),

      s("from", fmt([[
        from {} import {}
      ]], { i(1, "module"), i(2, "function") })),

      s("flask", fmt([[
        from flask import Flask, render_template, request, jsonify
        
        app = Flask(__name__)
        
        @app.route('/')
        def {}():
            return render_template('{}')
        
        if __name__ == '__main__':
            app.run(debug=True)
      ]], { i(1, "index"), i(2, "index.html") })),

      s("fastapi", fmt([[
        from fastapi import FastAPI
        from pydantic import BaseModel
        
        app = FastAPI()
        
        class {}(BaseModel):
            {}
        
        @app.get("/")
        async def root():
            return {{"message": "Hello World"}}
        
        @app.post("/{}s/")
        async def create_{}(item: {}):
            return item
      ]], { 
        i(1, "Item"), 
        i(2, "name: str"), 
        rep(1), 
        rep(1), 
        rep(1) 
      })),

      s("dataclass", fmt([[
        from dataclasses import dataclass
        
        @dataclass
        class {}:
            {}
      ]], { i(1, "ClassName"), i(2, "name: str") })),
    })

    -- Custom React/JSX snippets
    ls.add_snippets("javascriptreact", {
      s("rfc", fmt([[
        import React from 'react';
        
        const {} = () => {{
          return (
            <div>
              {}
            </div>
          );
        }};
        
        export default {};
      ]], { i(1, "ComponentName"), i(2, "// Component content"), rep(1) })),

      s("rcc", fmt([[
        import React, {{ Component }} from 'react';
        
        class {} extends Component {{
          constructor(props) {{
            super(props);
            this.state = {{
              {}
            }};
          }}
        
          render() {{
            return (
              <div>
                {}
              </div>
            );
          }}
        }}
        
        export default {};
      ]], { i(1, "ComponentName"), i(2, "// state"), i(3, "// JSX"), rep(1) })),

      s("useState", fmt([[
        const [{}, set{}] = useState({});
      ]], { i(1, "state"), f(function(args) 
        return args[1][1]:gsub("^%l", string.upper)
      end, {1}), i(2, "initialValue") })),

      s("useEffect", fmt([[
        useEffect(() => {{
          {}
        }}, [{}]);
      ]], { i(1, "// effect"), i(2, "// dependencies") })),

      s("useContext", fmt([[
        const {} = useContext({});
      ]], { i(1, "contextValue"), i(2, "Context") })),

      s("import", fmt([[
        import {{ {} }} from '{}';
      ]], { i(1, "component"), i(2, "./component") })),
    })

    -- Custom TypeScript snippets
    ls.add_snippets("typescript", {
      s("interface", fmt([[
        interface {} {{
          {}
        }}
      ]], { i(1, "InterfaceName"), i(2, "property: string;") })),

      s("type", fmt([[
        type {} = {{
          {}
        }};
      ]], { i(1, "TypeName"), i(2, "property: string;") })),

      s("enum", fmt([[
        enum {} {{
          {}
        }}
      ]], { i(1, "EnumName"), i(2, "VALUE1,\n  VALUE2") })),

      s("class", fmt([[
        class {} {{
          constructor({}) {{
            {}
          }}
          
          {}
        }}
      ]], { i(1, "ClassName"), i(2, "private property: string"), i(3, "this.property = property;"), i(4, "// methods") })),
    })

    -- Custom HTML snippets
    ls.add_snippets("html", {
      s("html5", fmt([[
        <!DOCTYPE html>
        <html lang="en">
        <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>{}</title>
        </head>
        <body>
          {}
        </body>
        </html>
      ]], { i(1, "Document Title"), i(2, "<!-- Content -->") })),

      s("form", fmt([[
        <form action="{}" method="{}">
          {}
          <button type="submit">{}</button>
        </form>
      ]], { i(1, "/submit"), i(2, "POST"), i(3, "<!-- Form fields -->"), i(4, "Submit") })),

      s("table", fmt([[
        <table>
          <thead>
            <tr>
              <th>{}</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>{}</td>
            </tr>
          </tbody>
        </table>
      ]], { i(1, "Header"), i(2, "Data") })),
    })

    -- Custom CSS snippets
    ls.add_snippets("css", {
      s("flex", fmt([[
        display: flex;
        justify-content: {};
        align-items: {};
      ]], { i(1, "center"), i(2, "center") })),

      s("grid", fmt([[
        display: grid;
        grid-template-columns: {};
        gap: {};
      ]], { i(1, "repeat(auto-fit, minmax(200px, 1fr))"), i(2, "1rem") })),

      s("media", fmt([[
        @media (max-width: {}) {{
          {}
        }}
      ]], { i(1, "768px"), i(2, "/* Mobile styles */") })),
    })

    -- Custom Java snippets
    ls.add_snippets("java", {
      s("class", fmt([[
        public class {} {{
            {}
        }}
      ]], { i(1, "ClassName"), i(2, "// Class content") })),

      s("main", fmt([[
        public static void main(String[] args) {{
            {}
        }}
      ]], { i(1, "System.out.println(\"Hello World!\");") })),

      s("method", fmt([[
        public {} {}({}) {{
            {}
        }}
      ]], { i(1, "void"), i(2, "methodName"), i(3, ""), i(4, "// Method body") })),

      s("for", fmt([[
        for (int {} = 0; {} < {}; {}++) {{
            {}
        }}
      ]], { i(1, "i"), rep(1), i(2, "length"), rep(1), i(3, "// Loop body") })),

      s("foreach", fmt([[
        for ({} {} : {}) {{
            {}
        }}
      ]], { i(1, "Type"), i(2, "item"), i(3, "collection"), i(4, "// Loop body") })),
    })

    -- Snippet configuration
    ls.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
          active = {
            virt_text = { { "choiceNode", "Comment" } },
          },
        },
      },
    })

    -- Key mappings for snippet expansion
    vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump(1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-H>", function() ls.jump(-1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-E>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, {silent = true})
  end,
}
