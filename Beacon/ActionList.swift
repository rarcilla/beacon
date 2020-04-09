
import SwiftUI

struct HazardAction: Identifiable {
    let id: Int
    let hazardType: String
    let when: String
    let textToDisplay: String
    let step: String
    
}
struct ActionList : View {
  @State var earthquakeBeforeActionList = [
    HazardAction(id: 001, hazardType: "Earthquake", when: "before", textToDisplay: "Be prepared to be on your own for a minimum of three days to one week by developing our emergency plan, putting together your emergency kit and connect with your neighbours", step: "1"),
    HazardAction(id: 002, hazardType: "Earthquake", when: "before", textToDisplay: "Be prepared to be on your own for a minimum of three days to one week by developing your emergency plan, putting together your emergency kit and connect with your neighbours", step: "2"),
    HazardAction(id: 003, hazardType: "Earthquake", when: "before", textToDisplay: "Be prepared to be on your own for a minimum of three days to one week by developing your emergency plan, putting together your emergency kit and connect with your neighbours", step: "3"),
  ]
    
  var body: some View {
    NavigationView {
      List(earthquakeBeforeActionList) { hazardAction in
        HStack {
          Text(hazardAction.step)
          Text(hazardAction.textToDisplay)
        }
      }.navigationBarTitle(Text("Actions"))
    }
  }
}

struct ActionList_Previews: PreviewProvider {
    static var previews: some View {
        ActionList()
    }
}
