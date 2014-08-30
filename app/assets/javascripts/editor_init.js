$(function() {
  $('textarea.editor').each(function() {
    var editor, editor_element;
    editor = CodeMirror.fromTextArea(this, {
      mode: 'markdown',
      theme: "elegant",
      extraKeys: {
        "Enter": "newlineAndIndentContinueMarkdownList"
      }
    });
    editor_element = editor.getWrapperElement();
    return $(editor_element).addClass('form-control');
  });
});
