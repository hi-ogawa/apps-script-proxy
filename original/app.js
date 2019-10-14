function doGet(e) {
  if (!e.parameter.url) {
    return respondJson({
      status: 'error',
      content: 'Required parameter: url',
    });
  }

  var options = {};
  if (e.parameter.options) {
    try {
      options = JSON.parse(e.parameter.options);
    } catch (e) {
      return respondJson({
        status: 'error',
        content: e.message,
      });
    }
  }

  var response;
  try {
    response = UrlFetchApp.fetch(e.parameter.url, options);
  } catch (e) {
    return respondJson({
      status: 'error',
      content: e.message,
    });
  }

  return respondJson({
    status: 'success',
    content: response.getContentText(),
  });
}

function respondJson(obj) {
  return ContentService.createTextOutput(JSON.stringify(obj)).setMimeType(ContentService.MimeType.JSON);
}
