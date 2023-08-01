// This file contains your Data Connector logic
// 1. User PB Person Model GW.
// 2. Set create in dataset after publish
// 3. Test connect bắt buộc phải sử dụng function trong custom conector (handlinggatewa.Contents) để vertify.
// 4. Không sửa dụng table trong parameter của funtion nếu muốn đưa lên GW.
[Version = "1.0.0"]
section handlinggatewa;

[DataSource.Kind="handlinggatewa", Publish="handlinggatewa.Publish"]
shared handlinggatewa.Contents = (message as text) =>
    let
        GetFileContents = Extension.Contents("GetFileContents.csv"),
        Source = Csv.Document(GetFileContents,[Delimiter=",", Columns=9, Encoding=65001, QuoteStyle=QuoteStyle.None])
    in
        Source;

// Data Source Kind description
handlinggatewa = [
    TestConnection = (dataSourcePath) => 
    let
            json = Json.Document(dataSourcePath),
            message = json[message]
        in   
        { "handlinggatewa.Contents",message}
    ,
        
    Authentication = [
        Implicit = []
    ]
];

// Data Source UI publishing description
handlinggatewa.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = handlinggatewa.Icons,
    SourceTypeImage = handlinggatewa.Icons
];

handlinggatewa.Icons = [
    Icon16 = { Extension.Contents("handlinggatewa16.png"), Extension.Contents("handlinggatewa20.png"), Extension.Contents("handlinggatewa24.png"), Extension.Contents("handlinggatewa32.png") },
    Icon32 = { Extension.Contents("handlinggatewa32.png"), Extension.Contents("handlinggatewa40.png"), Extension.Contents("handlinggatewa48.png"), Extension.Contents("handlinggatewa64.png") }
];
