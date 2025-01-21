;extends

(call
  function: (identifier) @_func (#eq? @_func "SQL")
  arguments: (argument_list
    (string
      (string_content) @injection.content
      (#set! injection.language "sql"))))

(call
  function: (identifier) @_func (#eq? @_func "SC")
  arguments: (argument_list
    (string
      (string_content) @injection.content
      (#set! injection.language "supercollider"))))
