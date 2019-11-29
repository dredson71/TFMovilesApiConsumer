//
//  ContentView.swift
//  ApiConsumer
//
//  Created by Cheryl Mori Gonzales on 11/29/19.
//  Copyright © 2019 DiegoNarreaM. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct ContentView: View {
    @ObservedObject var obs = observer()
    var body: some View {
        NavigationView{
            List(obs.datas){ i in
                card(name: i.name)
            }.navigationBarTitle("JSON Parse")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class observer : ObservableObject{
    @Published var datas = [datatype]()
    init(){
        Alamofire.request("https://api.github.com/users/hadley/orgs").responseData{(data) in
            let json = try! JSON(data: data.data!)
            for i in json{
                
                self.datas.append(datatype(id: i.1["id"].intValue, name:
                    i.1["login"].stringValue, url: i.1["login"].stringValue))
            }
        }
    }
}

//o represents the number of indexes in json
//1 represents the json data of each index

struct datatype : Identifiable{
    var id: Int
    var name: String
    var url: String
}


struct card: View{
    var name=""
    var body: some View{
        HStack{
            Text(name).fontWeight(.heavy)
        }
    }
}
