module.exports = (grunt) =>
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'

		bower:
			install:
				options:
					targetDir: 'demo/components'

		## Compile coffeescript
		coffee:
			compile:
				files: [
					{
						expand: true
						cwd: 'src'
						src: ['DragListener.coffee']
						dest: 'dist'
						ext: '.js'
					},
					{
						expand: true
						cwd: 'src'
						src: ['*.coffee']
						dest: 'demo'
						ext: '.js'
					}
				]

		watch:
			markdown:
				files: 'README.html'
				tasks: 'markdown'
			
			coffee:
				files: ['src/**/*.coffee']
				tasks: ['coffee']

		connect:
			server:
				options:
					keepalive: true
					port: 9001
					base: 'demo'

		exec:
			server:
				command: 'grunt connect &'

			open:
				command: 'open http://localhost:9001/'

		
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-connect'
	grunt.loadNpmTasks 'grunt-exec'
	grunt.loadNpmTasks 'grunt-bower-task'
	
	grunt.registerTask 'default', ['bower', 'compile']

	grunt.registerTask 'server', ['exec:server', 'exec:open', 'watch']

	grunt.registerTask 'commit', ['default', 'git']
	
	grunt.registerTask 'compile', 'Compile coffeescript', ['coffee']
