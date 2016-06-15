# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {
	templateData:
		site:
			title: '輔大性侵事件爭點整理',
		status: [
			{ name: '確認無共識', c: 'conflict' },
			{ name: '確認指控有誤', c: 'resolved' },
			{ name: '工作小組反駁', c: 'explained' },
			{ name: '初步進展，待後續釐清', c: 'doing' },
			{ name: '尚未核對', c: 'todo' }
		]
		statusC: {
			'確認指控有誤': 'green'
			'工作小組反駁': 'orange'
			'初步進展，待後續釐清': 'yellow'
			'尚未核對': 'teal'
			'確認無共識': 'red'
		}
		
	collections:
		issues: -> @getCollection("html").findAllLive({isIssue:true},[{order:1}])
		resolved: -> @getCollection("html").findAllLive({isIssue:true,status:'確認指控有誤'},[{order:1}])
		explained: -> @getCollection("html").findAllLive({isIssue:true,status:'工作小組反駁'},[{order:1}])
		doing: -> @getCollection("html").findAllLive({isIssue:true,status:'初步進展，待後續釐清'},[{order:1}])
		todo: -> @getCollection("html").findAllLive({isIssue:true,status:'尚未核對'},[{order:1}])
		conflict: -> @getCollection("html").findAllLive({isIssue:true,status:'確認無共識'},[{order:1}])
}

# Export the DocPad Configuration
module.exports = docpadConfig
