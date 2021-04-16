import Foundation

struct Dialog {
    let id: Int
    let speaker1: String
    let speaker2: String
    let imageName1: String
    let imageName2: String
    let dialog: String
}

struct DialogData {
    let dialogs: [Dialog] = [
        Dialog(id: 1, speaker1: "Ryo", speaker2: "", imageName1: "Player", imageName2: "Scientist", dialog: "Hi Mr. Scen what are you doing?"),
        Dialog(id: 2, speaker1: "", speaker2: "Mr. Scen", imageName1: "Player", imageName2: "Scientist", dialog: "Ah! Ryo, you show up at the right time. Today I want to create the greatest tools that can help humanity. But I'm still missing some materials. Can you help me collect it?"),
        Dialog(id: 3, speaker1: "Ryo", speaker2: "", imageName1: "Player", imageName2: "Scientist", dialog: "Sure, how can I help you?"),
        Dialog(id: 4, speaker1: "", speaker2: "Mr. Scen", imageName1: "Player", imageName2: "Scientist", dialog: "You can go inside the mine, and collect everything you find inside. I'll wait for you in the other side"),
    ]
}
