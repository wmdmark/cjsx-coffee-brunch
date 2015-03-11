transform = require('coffee-react-transform')
coffeescript = require('coffee-script')

module.exports = class ReactCoffeeCompiler
  brunchPlugin: yes
  type: 'javascript'
  extension: 'cjsx'
  pattern: /\.cjsx/

  constructor: (@config) ->
    @includeHeader= @config?.plugins?.react?.autoIncludeCommentBlock is yes

  compile: (params, callback) ->
    source = if @includeHeader
        "# @cjsx React.DOM \n#{ params.data }"
      else
        params.data

    try
      output = transform(source)
      output = coffeescript.compile(output, {})
    catch err
      console.log "ERROR", err
      return callback err.toString()

    callback null, data:output
