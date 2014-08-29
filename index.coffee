through2 = require 'through2'

# requires 'html'
module.exports = (options = { plainText: yes }) ->
    mode = if options.plainText then 'text' else 'html'

    processFile = (file, enc, done) ->
        if file.isPost and file.$
            { $ } = file

            isDescriptive = (i, paragraph) ->
                $paragraph = $ paragraph
                $paragraph.text().trim().match /\.$/gi

            file.title = $('h1').first().text().trim()
            file.image = $('img').first().attr('src') || null

            # @TODO: enhance excerpt
            file.excerpt =
                $('p')
                .filter(isDescriptive)[mode]()

        done null, file

    through2.obj processFile