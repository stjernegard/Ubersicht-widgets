command: "curl -s https://www.reddit.com/r/news+worldnews.json -A newsbot"

refreshFrequency: '10m'

style: """
  // Position this where you want
  top 20px
  left 40px
  width 400px

  div
    // background-color rgba(0,0,0,0.1)
    padding 5px 15px
    font-family "Roboto"
    font-size 13px
    text-shadow 1px 0 0 rgba(#000, .3), 0 -1px 0 rgba(#000, .3), 0 1px 0 rgba(#000, .3), -1px 0 0 rgba(#000, .3)
    -webkit-font-smoothing antialiased

  p
    display block

    .upvotes
      text-decoration none
      color hsl(0,0,100)
      font-weight 600

    .title
      display inline
      background-color rgba(0,0,0,0.01)
      text-decoration none
      color hsl(0,0,100)
      font-weight 400
"""


render: -> "<div></div>"

update: (output, domEl) ->
  forEachPost = (children, func) ->
    for child in children
      func child.data

  first = (arr, count = 1) ->
    arr[0...count]

  try json = JSON.parse(output) catch then return

  doc = $(domEl).find("div").empty()
  forEachPost first(json.data.children, 10), (post) ->
    doc.append """
      <p>
        <a class="upvotes" href="https://reddit.com#{post.permalink}">
          #{post.ups}
        </a>
        <a class="title" href="#{post.url}">
          #{post.title}
        </a>
      </p>
    """
