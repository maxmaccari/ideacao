const listenIdeas = (socket, context) => {
  const channel = socket.channel('ideas:lobby', {})

  channel.on("newIdea", (idea) => {
    context.commit('addIdea', idea)
  })

  channel.on("newFeedback", (response) => {
    context.commit('addFeedback', response)
  })

  return channel.join()
}

export default listenIdeas