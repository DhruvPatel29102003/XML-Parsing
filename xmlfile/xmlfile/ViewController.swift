import UIKit


class ViewController: UIViewController {
    var xmlDict = [String: Any]()
    var lstXmlDict = [[String: Any]]()
    var lstFeeds = [Feed]()
    var element = ""
    var summaryString = ""

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let fileUrl = Bundle.main.url(forResource: "sample", withExtension: "xml"){
            guard let data = try? Data(contentsOf: fileUrl) else{
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        
    }
    
   
}
extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstFeeds.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as! MyTableViewCell
        cell.lblTitle.text = lstFeeds[indexPath.row].title
        cell.lblSummery.text = lstFeeds[indexPath.row].summery
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: "MyViewController")as! MyViewController
        detailvc.titleText = lstFeeds[indexPath.row].title ?? ""
        detailvc.summaryText = lstFeeds[indexPath.row].summery ?? ""
        self.navigationController?.pushViewController(detailvc, animated: true)
    }
}



extension ViewController: XMLParserDelegate{
    
    func parserDidStartDocument(_ parser: XMLParser) {
        print("Start Parsing")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("Did Start Element: \(elementName)")
        if elementName == "entry"{
            xmlDict = [:]
        }else{
            element = elementName
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("Found Element: \(string)")
        if string.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
            summaryString += string
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("Did End Element: \(elementName)")
        if elementName == "entry" {
            lstXmlDict.append(xmlDict)
            summaryString = ""
        }else{
            xmlDict[element] = summaryString
        }
        
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        for x in lstXmlDict {
            lstFeeds.append(Feed(title: x["title"] as? String, summery: x["summary"] as? String))
            
        }
        
        tableView.reloadData()
    }
}
