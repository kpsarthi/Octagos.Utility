namespace octagos_utility.Model;

public class HtmlToPdfConverterRequest{
    public string HtmlString { get; set; }
    public int PdfHeight { get; set; }
    public int PdfWidth { get; set; }
}