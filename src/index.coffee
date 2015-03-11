transform = require('coffee-react-transform')
coffeescript = require('coffee-script')

module.exports = class ReactCoffeeCompiler
  brunchPlugin: yes
  type: 'javascript'
  extension: 'cjsx'
  pattern: /\.cjsx/

  constructor: (@config) ->
    @includeHeader= @config?.plugins?.react?.autoIncludeCommentBlock is yes

  compile: (data, path, callback) ->
    source = if @includeHeader
        "# @cjsx React.DOM \n#{ data }"
      else
        data
    try
      output = transform(source)
      output = coffeescript.compile(output, {})
    catch err
      console.log "ERROR", err
      return callback err.toString()

    result = "module.exports = #{output}"
    callback(null, result)
