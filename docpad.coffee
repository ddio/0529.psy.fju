# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {
	templateData:
		site:
			title: '輔大性侵事件爭點整理'
		statusC: {
			'已釐清': 'blue'
			'初步進展，待後續釐清': 'yellow'
			'尚未核對': 'teal'
			'確認無共識': 'red' 
		}
	collections:
		resolved: -> @getCollection("html").findAllLive({isIssue:true,status:'已釐清'})
		doing: -> @getCollection("html").findAllLive({isIssue:true,status:'初步進展，待後續釐清'})
		todo: -> @getCollection("html").findAllLive({isIssue:true,status:'尚未核對'})
		conflict: -> @getCollection("html").findAllLive({isIssue:true,status:'確認無共識'})
	renderPasses: 2
}

# Export the DocPad Configuration
module.exports = docpadConfig
