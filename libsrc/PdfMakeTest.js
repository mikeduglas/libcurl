function print(){
  window.event.preventDefault()
  // this is just a simulation of the open event, replacing it with print produces the same result
  var docDefinition = { content: {text:'This is an sample PDF printed with pdfMake',fontSize:15} };
  pdfMake.createPdf(docDefinition).open();
}