###
  This is the main script file. It can attach to the terminal
###

COMPLETE_URL = "/whats-next/"


###
  Array of question objects
###

q = []
q.push ({
html: """
      <h3>Getting started</h3>
      <p>There are actually two programs, a Docker daemon which manages al the containers, and the Docker client.
      The client acts as a remote control on the daemon. On most systems, like in this emulator, both run on the
      same host.</p>
      """
assignment: """
      <h3>Assignment</h3>
      <p>Check which Docker version is running</p>
      <p>This will help you verify the daemon is running. If you see which version is running you know you are all set.</p>
      """
tip: "try typing <code>docker</code> to see the full list of accepted arguments"
command_expected: ['docker', 'version']
result: """<p>Well done! Let's move to the next assignment.</p>"""
})

q.push ({
html: """
      <h3>Searching for images</h3>
      <p>The easiest way to get started is to use a container image from someone else. Container images are
      available on the docker index - a central place to store images. You can find them using the commandline
      and online, at <a href="https://index.docker.io">index.docker.io</a></p>
      """
assignment: """
      <h3>Assignment</h3>
      <p>Use the commandline to search for an image called tutorial</p>
      """
command_expected: ['docker', 'search', 'tutorial']
result: """<p>You found it!</p>"""
tip: "the format is <code>docker search &lt;string&gt;</code>"
})

q.push ({
html: """
      <h3>Downloading container images</h3>
      <p>Container images can be downloaded just as easily, using <code>docker pull</code>.</p>
      <p>The name you specify is made up of two parts: the <em>username</em> and the <em>repository name</em>,
      divided by a slash `/`.</p>
      <p>A group of special, trusted images can be retrieved by just their repository name.</p>
      """
assignment:
      """
      <h3>Assignment</h3>
      <p>Please download the tutorial image you have just found</p>
      """
command_expected: ['docker', 'pull', 'learn/tutorial']
result: """<p>Cool. Look at the results. You'll see that docker has downloaded a number of layers. In Docker all images (except the base image) are made up of several cumulative layers.</p>"""
tip: """<p>Don't forget to pull the full name of the repository e.g. 'learn/tutorial'</p>
     <p>Look under 'show expected command if you're stuck.</p>
     """
})


q.push ({
html: """
      <h3>Hello world from a container</h3>
      <p>You can think about containers as an operating system in a box, except they do not need to be booted
      before you can run commands in them. Instead, they are started <em>by</em> running a process in them. They
      also stop as soon as the process completes.<p>
      """
assignment: """
      <h3>Assignment</h3>
      <p>Make our freshly loaded container image output "hello world"</p>
      <p>To do so you should run 'echo' in the container and have that say "hello world"

      """
command_expected: ["docker", "run", "learn/tutorial", "echo"]
command_show: ["docker", "run", "learn/tutorial", 'echo "hello world"']

result: """<p>Great! Hellooooo World!</p>"""
intermediateresults: [
  """<p>You seem to be almost there. Did you give the command `echo "hello world"` """,
  """<p>You've got the arguments right. Did you get the command? Try <em>/bin/bash </em>?</p>"""
  ]
tip: """
     <p>The command <code>docker run</code> takes a minimum of two arguments. An image name, and the command you want to execute
     within that image.</p>
     <p>Check the expected command below if it does not work as expected</p>
    """
})

q.push ({
html: """
      <h3>Installing things in the container</h3>
      <p>Next we are going to install a simple program (ping) in the container. The image is based upon ubuntu, so we
      give the command “apt-get install -y ping”. Docker will run this command in the container and exit when done.</p>
      <p>Note that even though the container stops right after a command completes the changes are not forgotten.</p>
      """
assignment: """
      <h3>Assignment</h3>
      <p>Install 'ping' inside of the container.</p>
      """
command_expected: ["docker", "run", "learn/tutorial", "apt-get", "install", "-y", "ping"]
result: """<p>That worked!</p>"""
intermediateresults: [
  """<p>Not specifieng -y on the apt-get install command will work for ping, because it has no other dependencies, but
  it will fail when apt-get wants to install dependencies. To get into the habit, please add -y after apt-get.</p>""",
]
tip: """
     <p>don't forget to use -y for noninteractive mode installation</p>
     <p>Not specifieng -y on the apt-get install command will fail for most commands because it expects you to accept
     (y/n) but you cannot respond.
     </p>
     """
})

q.push ({
html: """
      <h3>Save your changes</h3>
      <p>After you make changes (by running a command inside a container) you probably want to save those changes.
      This will enable you to later start from this point onwards.</p>
      <p>With Docker, the process of saving the state is called <em>committing</em>. Commit basically saves the difference
      between the old image and the new state. The result is a new layer.</p>
      """
assignment: """
      <h3>Assignment</h3>
      <p>First use <em>docker ps -l</em> to find the ID of the container you created by installing ping.</p>
      <p>Then save (commit) this container with the repository name `learn/ping` </p>
      """
command_expected: ["docker", "commit", "698", "learn/ping"]
command_show: ["docker", "commit", "698", 'learn/ping']
result: """<p>That worked! Please take note that Docker has returned a new ID. This id is the <em>image id</em>.
        You will need it next.</p>"""
intermediateresults: ["""You have not specified the correct repository name (learn/ping). This is not wrong, but giving your images a name
                      make them much easier to work with."""]
tip: """<ul>
     <li>Giving just <code>docker commit</code> will show you the possible arguments.</li>
     <li>You don't need to copy the entire ID. Three or four characters is usually enough.</li>
     </ul>"""
})


q.push ({
html: """
      <h3>Run your new image</h3>
      <p>Now you have basically setup a complete, self contained environment with the 'ping' program installed. </p>
      <p>Your image can now be run on any host that runs docker.</p>
      <p>Lets run this image on this machine.</p>
      """
assignment: """
      <h3>Assignment</h3>
      <p>Run the ping program to ping www.google.com</p>

      """
command_expected: ["docker", "run", 'learn/ping', 'ping', 'www.google.com' ]
result: """<p>That worked! Note that normally you can use Ctrl-C to disconnect. The container will keep running. This
        container will disconnect automatically.</p>"""
intermediateresults: ["""You have not specified a repository name. This is not wrong, but giving your images a name
                      make them much easier to work with."""]
tip: """<ul>
     <li>Make sure to use the repository name learn/ping to run ping with</li>
     </ul>"""
})




q.push ({
html: """
      <h3>Check your running image</h3>
      <p>You now have a running container. Let's see what is going on.</p>
      <p>Using <code>docker ps</code> we can see a list of all running containers, and using <code>docker inspect</code>
      we can see all sorts of usefull information about this container.</p>
      """
assignment: """
      <h3>Assignment</h3>
      <p><em>Find the container id</em> of the running container, and then inspect the container using <em>docker inspect</em>.</p>

      """
command_expected: ["docker", "inspect", "efe" ]
result: """<p>Success! Have a look at the output. You can see the ip-address, status and other information.</p>"""
intermediateresults: ["""You have not specified a repository name. This is not wrong, but giving your images a name
                      make them much easier to work with."""]
tip: """<ul>
     <li>Remember you can use a partial match of the image id</li>
     </ul>"""
})



q.push ({
html: """
      <h3>Push the image to the registry</h3>
      <p>Now you have verified that your new application container works as it should, you can share it.</p>
      <p>Docker comes with a complete image sharing service, you can push your image there for yourself and others
      to retrieve.</p>
      """
assignment: """
      <h3>Assignment</h3>
      <p>Push your container image learn/ping to the index</p>

      """
command_expected: ["docker", "push"]
command_show: ["docker", "push", "learn/ping"]
result: """<p>Yes, congratulations! You are all done!</p>"""
intermediateresults: [""" """]
tip: """<ul>
     <li>Docker images will show you which images are currently on your host</li>
     <li>You can only push images to your own namespace.</li>
     <li>For this tutorial we assume you are already logged in as the 'learn' user..</li>
     </ul>"""
})



#
#q.push ({
#html: """
#      <h3>Interactive Shell</h3>
#      <p>Now, since Docker provides you with the equivalent of a complete operating system you are able to get
#      an interactive shell (tty) <em>inside</em> of the container.</p>
#      <p>Since we want a prompt in the container, we need to start the shell program in the container. </p>
#      <p>You may never have manually started it before, but a popular one typically lives at `/bin/bash`</p>
#      """
#assignment: """
#      <h3>Assignment</h3>
#      <p>Your goal is to run the tutorial container you have
#      just downloaded and get a shell inside of it.</p>
#      """
#command_expected: ["docker", "run", "-i", "-t", "learn/tutorial", "/bin/bash"]
#result: """<p>Great!! Now you have an interactive terminal</p>"""
#intermediateresults: [
#  """<p>You seem to be almost there. Did you use <em>-i and -t</em>?</p>""",
#  """<p>You've got the arguments right. Did you get the command? Try <em>/bin/bash </em>?</p>"""
#  """<p>You have the command right, but the shell exits immediately, before printing anything</p>
#      <p>You will need to attach your terminal to the containers' terminal.</p>
#  """
#  ]
#tip: """Start by looking at the results of `docker run`, it shows which arguments exist"""
#})
#


# the index arr
questions = []




###
  Register the terminal
###

@webterm = $('#terminal').terminal(interpreter, basesettings)




EVENT_TYPES =
  none: "none"
  start: "start"
  command: "command"
  next: "next"
  feedback: "feedback"
  complete: "complete"



###
  Sending events to the server
###

logEvent = (data, feedback) ->
    ajax_load = "loading......";
    loadUrl = "/tutorial/api/";
    if not feedback
      callback = (responseText) -> $("#ajax").html(responseText)
    else
      callback = (responseText) ->
        results.set("Thank you for your feedback! We appreciate it!", true)
        $("#ajax").html(responseText)

    if not data then data = {type: EVENT_TYPES.none}
    data.question = current_question


    $("#ajax").html(ajax_load);
    $.post(loadUrl, data, callback, "html")



###
  Event handlers
###


## next
$('#buttonNext').click ->
  next()
  $('#results').hide()

$('#buttonFinish').click ->
  window.open(COMPLETE_URL)


## previous
$('#buttonPrevious').click ->
  previous()
  $('#results').hide()

## Stop mousewheel on target
$('body').on 'mousewheel', (event) ->
  # not used because it gives trouble when there is text-overflow on leftside
  # return false


## submit feedback
$('#feedbackSubmit').click ->
  feedback = $('#feedbackInput').val()
  data = { type: EVENT_TYPES.feedback, feedback: feedback}
  logEvent(data, feedback=true)

## fullsize
$('#fullSizeOpen').click ->
  goFullScreen()

@goFullScreen = () ->
  console.debug("going to fullsize mode")
  $('.togglesize').removeClass('startsize').addClass('fullsize')

  $('.hide-when-small').css({ display: 'inherit' })
  $('.hide-when-full').css({ display: 'none' })

  webterm.resize()
  data = { type: EVENT_TYPES.start }
  logEvent(data)
  next(0)

## leave fullsize
$('#fullSizeClose').click ->
  leaveFullSizeMode()

leaveFullSizeMode = () ->
  console.debug "leaving full-size mode"

  $('.togglesize').removeClass('fullsize').addClass('startsize')

  $('.hide-when-small').css({ display: 'none' })
  $('.hide-when-full').css({ display: 'inherit' })

  webterm.resize()

## click on tips
$('#command').click () ->
  if not $('#commandHiddenText').hasClass('hidden')
    $('#commandHiddenText').addClass("hidden").hide()
    $('#commandShownText').hide().removeClass("hidden").fadeIn()



###
  Navigation amongst the questions
###


current_question = 0
next = (which) ->
  # before increment clear style from previous question progress indicator
  $('#marker-' + current_question).addClass("complete").removeClass("active")

  if not which and which != 0
    current_question++
  else
    current_question = which

  questions[current_question]()
  results.clear()
  @webterm.focus()

  if not $('#commandShownText').hasClass('hidden')
    $('#commandShownText').addClass("hidden")
    $('#commandHiddenText').removeClass("hidden").show()

  # enable history navigation
  history.pushState({}, "", "#" + current_question);
  data = { 'type': EVENT_TYPES.next }
  logEvent(data)

  # change the progress indicator
  $('#marker-' + current_question).removeClass("complete").addClass("active")

  $('#question-number').find('text').get(0).textContent = current_question

  ## When the last question comes up change the next button to complete
  length = questions.length
  if current_question == length-1
    # last question
    $('#buttonNext').addClass("hidden")
    $('#buttonFinish').removeClass("hidden")
  else
    $('#buttonFinish').addClass("hidden")
    $('#buttonNext').removeClass("hidden")




  return

previous = () ->
  current_question--
  questions[current_question]()
  results.clear()
  @webterm.focus()
  return



results = {
  set: (htmlText, intermediate) ->
    if intermediate
      console.debug "intermediate text received"
      $('#results').addClass('intermediate')
      $('#buttonNext').hide()
    else
      $('#buttonNext').show()

    window.setTimeout ( () ->
      $('#resulttext').html(htmlText)
      $('#results').fadeIn()
      $('#buttonNext').removeAttr('disabled')
    ), 300

  clear: ->
    $('#resulttext').html("")
    $('#results').fadeOut('slow')
#    $('#buttonNext').addAttr('disabled')
}





###
  Transform question objects into functions
###

buildfunction = (q) ->
  _q = q
  return ->
    console.debug("function called")

    $('#instructions').hide().fadeIn()
    $('#instructions .text').html(_q.html)
    $('#instructions .assignment').html(_q.assignment)
    $('#tipShownText').html(_q.tip)
    if _q.command_show
      $('#commandShownText').html(_q.command_show.join(' '))
    else
      $('#commandShownText').html(_q.command_expected.join(' '))

    window.immediateCallback = (input, stop) ->
      if stop == true # prevent the next event from happening
        doNotExecute = true
      else
        doNotExecute = false

      if doNotExecute != true
        console.log (input)

        data = { 'type': EVENT_TYPES.command, 'command': input.join(' '), 'result': 'fail' }

        # Was like this:  if not input.switches.containsAllOfThese(_q.arguments)
        if input.containsAllOfTheseParts(_q.command_expected)
          data.result = 'success'

          setTimeout( ( ->
            @webterm.disable()
            $('#buttonNext').focus()
          ), 1000)

          results.set(_q.result)
          console.debug "contains match"
        else
          console.debug("wrong command received")

        # call function to submit data
        logEvent(data)
      return

    window.intermediateResults = (input) ->
      results.set(_q.intermediateresults[input], intermediate=true)
    return


statusMarker = $('#progress-marker-0')
progressIndicator = $('#progress-indicator')#

drawStatusMarker = (i) ->
  console.log i

  if i == 0
    marker = statusMarker
  else
    marker = statusMarker.clone()
    marker.appendTo(progressIndicator)

  marker.attr("id", "marker-" + i)
  marker.find('text').get(0).textContent = i
  marker.click( -> next(i) )


questionNumber = 0
for question in q
  f = buildfunction(question)
  questions.push(f)
  console.log questionNumber
  drawStatusMarker(questionNumber)
  questionNumber++



###
  Initialization of program
###

#load the first question, or if the url hash is set, use that
if (window.location.hash)
  try
    currentquestion = window.location.hash.split('#')[1].toNumber()
#    questions[currentquestion]()
#    current_question = currentquestion
    next(currentquestion)

  catch err
    questions[0]()
else
  questions[0]()

$('#results').hide()

