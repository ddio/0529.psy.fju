var fs = require('fs');
var parse = require('csv-parse');
var _ = require('underscore');
var marked = require('marked');

var listItems = {
	reason: true,
	reasonSrc: true,
	comment: true,
	commentSrc: true
}

var genIssue = function( data ) {

	if( data[0] == '' ) {
		return;
	}

	var content = {
		title: data[1],
		layout: 'issue',
		isIssue: true,
		src: data[2],
		status: data[3],
		result: data[4],
		reason: data[5],
		reasonSrc: data[6],
		comment: data[7],
		commentSrc: data[8],
		order: data[9]
	};

	var contentStr = _.reduce( content, function( memo, input, key ) {

		if( listItems[ key ] && input !== '' ) {
			var lines = input.split("\n");
			if( lines[0][0] === '>' ) {
				input = marked( lines.slice(1).join("\n") ).replace(/[\n\t]/g,"");
			} else if( lines.length > 1 ) {
				input = _.reduce( input.split("\n"), function( memo, line ) {
					if( line === '' ) {
						return memo;
					} else {
						line = '1. ' + line;
					}
					return memo + "\n" + line;
				}, '');
				input = marked( input ).replace( /[\n\t]/g, '' );
			} else {
				input = lines[0];
			}
		} else if( input === '' ) {
			input = '""';
		} else if( typeof input == 'string' ) {
			input = input.replace( "\n", '' );
		}

		return memo + key + ': ' + input + "\n";
	}, "---\n") + "---\n";

	var fileName = 'tmp/' + data[0] + '.html';
	fs.writeFile( fileName, contentStr, function( err ) {
		if( err ) {
			console.log( err );
		}
		console.log( fileName );
	});

}

var parser = parse( function(err, lines){

	lines.shift();

	lines.forEach( genIssue );
	
});

fs.createReadStream(__dirname+'/issues.csv').pipe(parser);
