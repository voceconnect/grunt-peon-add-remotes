###
add-remotes
@usage:
  peon add-remotes
###
module.exports = (grunt) ->
  desc = 'Adds git remotes for deployments'
  grunt.registerMultiTask('add-remotes', desc, () ->
    done = @async()
    async = require('async')
    exec = require('child_process').exec
    remoteToAdd = @data

    stopAsync = (err) ->
      if err
        grunt.log.error(err)
        grunt.fail.warn 'Remotes failed to update.'
      else
        msg = "\nThe '#{remoteToAdd.alias}' deployment remote is up to date."
        grunt.log.ok msg
      done()

    # callback(err, {"staging": "git@example.com/project.git", ...});
    getCurrentRemotes = (done) ->
      exec 'git remote -v', (err, stdout, stderr) ->
        remotes = {}
        if err
          grunt.log.writeln('FAIL')
          grunt.fatal(stderr)
        
        lines = stdout.split("\n")
        for line in lines
          parts = line.split(/[ \t]/)
          if parts.length is 3
            remotes[parts[0]] = parts[1]

        done err, remotes
 
    getCurrentRemotes (err, existingRemotes) ->
      addRemote = (remote, done) ->
        cmd = 'git remote add ' + remote.alias + ' ' + remote.url
        grunt.log.writeln "Added remote for " + remote.alias + '.'
        exec cmd, done
      
      updateRemote = (remote, done) ->
        cmd = 'git remote set-url ' + remote.alias + ' ' + remote.url
        grunt.log.writeln 'Updated remote for #{remote.alias}.'
        exec cmd, done
    
      setRemote = (remote, done) ->
        if not existingRemotes[remote.alias]?
          addRemote remote, done
        else if existingRemotes[remote.alias] is not remote.url
          updateRemote remote, done
        else
          msg = "Correct remote for '#{remote.alias}' already exists, skipping."
          grunt.log.writeln msg
          done()
    
      setRemote remoteToAdd, stopAsync

  )