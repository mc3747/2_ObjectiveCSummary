

  // NOTE: 
    // Modifying the URL below to another server will likely *NOT* work. Because of browser
    // security restrictions, we have to use a file server with special headers
    // (CORS) - most servers don't support cross-origin browser requests.
    //

    //
    // Disable workers to avoid yet another cross-origin issue (workers need the URL of
    // the script to be loaded, and currently do not allow cross-origin scripts)
    //
'use strict';

PDFJS.disableWorker = false;

var pdfDoc = null,
  pageNum = 1,
  pageRendering = false,
  pageNumPending = null,
  scale = 1.0,
  numPages = 1;
  //canvas = document.getElementById('the-canvas')


var BASE64_MARKER = ';base64,';


function convertDataURIToBinary(dataURI) {
  var base64Index = dataURI.indexOf(BASE64_MARKER) + BASE64_MARKER.length;
  var base64 = dataURI.substring(base64Index);
  var raw = window.atob(dataURI);
  var rawLength = raw.length;
  var array = new Uint8Array(new ArrayBuffer(rawLength));

  for(var i = 0; i < rawLength; i++) {
    array[i] = raw.charCodeAt(i);
  }
  return array;
}

function loadPDF(pdfAsDataUri)
{
    console.log("hahahha");
    var pdfAsArray = convertDataURIToBinary(pdfAsDataUri);
    PDFJS.getDocument(pdfAsArray).then(getPdf);
}

function show_pdf(url)
{
    console.log("hahahha");
    PDFJS.getDocument(url).then(getPdf);
}

function getPdf(pdfDoc_)
{
  pdfDoc = pdfDoc_;
  numPages =  pdfDoc.numPages;
  pageNum=1;
  pdfDoc.getPage(pageNum).then(handlePages);
}

function handlePages(page)
{
  //create new canvas
  var viewport = page.getViewport(1);
  var canvas = document.createElement( "canvas" );
  canvas.style.display="block";
  
  var context = canvas.getContext('2d');
  canvas.height = viewport.height;
  canvas.width = viewport.width;

  //render page
  page.render({canvasContext: context, viewport: viewport});

  //add canvas to body
  document.body.appendChild(canvas);

  //render new page
  pageNum++;
    if(pdfDoc!=null && pageNum<=numPages){
        pdfDoc.getPage(pageNum).then(handlePages);
    }else{
        console.log("pdf load complete");
        window.webkit.messageHandlers.AppModel.postMessage({
                                                           code: "00000",
                                                           msg: "pdf load complete"
                                                           });//和wkWebView交互
    }

}

