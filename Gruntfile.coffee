module.exports = (grunt) =>
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'

		bower:
			install: {}

		## Compile coffeescript
		coffee:
			compile:
				files: [
					{
						expand: true
						cwd: 'src'
						src: ['DragListener.coffee']
						dest: 'src'
						ext: '.js'
					},
					{
						expand: true
						cwd: 'src'
						src: ['main.coffee']
						dest: 'demo'
						ext: '.js'
					}
				]

		removelogging:
			files:
				expand: true
				cwd: 'dist'
				src: ['DragListener.min.js']
				dest: 'dist'
				ext: '.js'

		uglify:
			options:
				mangle: false
				compress: true
				banner: """/*!
						<%= pkg.name %> v<%= pkg.version %> 
						<%= pkg.description %>
						Build time: #{(new Date()).toString('dddd, MMMM ,yyyy')}
						*/\n\n"""
					
			javascript:
				files: {
					'dist/DragListener.min.js': 'dist/DragListener.js'
				}

		markdown:
			readmes:
				files: [
					{
						expand: true
						src: 'README.md'
						dest: 'dist'
						ext: '.html'
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
					base: ''

		exec:
			server:
				command: 'grunt connect &'

			open:
				command: 'open http://localhost:9001/'

		requirejs:
			compile:
				options:
					optimizeCss: false
					optimize: 'none'
					logLevel: 1
					name: "DragListener"
					out: "dist/DragListener.js"
					baseUrl: "src"
					exclude: ['EventEmitter', 'mootools']
					paths:{
						'domReady' : '../components/requirejs-domready/domReady'
						'DragListener': '../src/DragListener'
						'EventEmitter': '../components/EventEmitter/dist/EventEmitter'
						'mootools' : '../demo/mootools'
					}

		shell:
			bower_cache:
				command: 'bower cache-clean'
				options:
					stdout: true

			bower:
				command: 'bower install'
				options:
					stdout: true

		
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-remove-logging'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-markdown'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-connect'
	grunt.loadNpmTasks 'grunt-contrib-requirejs'
	grunt.loadNpmTasks 'grunt-exec'
	grunt.loadNpmTasks 'grunt-shell'
	grunt.loadNpmTasks 'grunt-bower-task'
	
	grunt.registerTask 'default', ['bower', 'compile']

	grunt.registerTask 'server', ['exec:server', 'exec:open', 'watch']

	grunt.registerTask 'commit', ['default', 'git']
	
	grunt.registerTask 'compile', 'Compile coffeescript and markdown', ['coffee', 'markdown']
