function showAddPostCodeForm() {
  $("#newCodePost").toggleClass("hidden");
  $("#addCodePostButton").toggleClass("hidden");
}

function showAddCodeCommentForm(id) {
  $(`#newCodeComment${id}`).toggleClass("hidden");
  $(`#addCodeCommentButton${id}`).toggleClass("hidden");
}
