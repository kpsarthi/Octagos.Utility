using Microsoft.AspNetCore.Mvc;
using octagos_utility.Model;
using SelectPdf;

namespace octagos_utility.Controllers;

[ApiController]
[Route("api/[controller]")]
public class HtmlToPdfConverterController: ControllerBase
{
    private readonly ILogger<HtmlToPdfConverterController> _logger;

    public HtmlToPdfConverterController(ILogger<HtmlToPdfConverterController> logger)
    {
        _logger = logger;
    }

    [HttpPost]    
    public byte[] Convert([FromBody] HtmlToPdfConverterRequest request){
        var converter = new HtmlToPdf();
        
        converter.Options.WebPageWidth = request.PdfWidth;
        converter.Options.WebPageHeight = request.PdfHeight;   

        var doc = converter.ConvertHtmlString(request.HtmlString);
        var pdfbytes = doc.Save();
        doc.Close();
        return pdfbytes;
    }

    [HttpGet]
    public string GetMessage(){
        return "Hello World!";
    }
}