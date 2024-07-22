import 'package:covid_tracker/Services/states_servics.dart';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {


  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServics  statesServics = StatesServics();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value){
                    setState(() {

                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search with country name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    )
                  ),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                    future: statesServics.countriesListApi(),
                    builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                      if(!snapshot.hasData)
                      {
                        return ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context,index){
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade700,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(height: 10,width: 89,color: Colors.white,),
                                      subtitle: Container(height: 10,width: 89,color: Colors.white,),
                                      leading: Container(height: 50,width: 50,color: Colors.white,),
                                    )

                                  ],

                                ),
                                );


                            });

                      }
                      else
                      {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){
                            String name = snapshot.data![index]['country'];
                            if(searchController.text.isEmpty)
                              {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          name: snapshot.data![index]['country'],
                                          totalCases: snapshot.data![index]['cases'] ?? 0,
                                          todayRecovered: snapshot.data![index]['recovered'] ?? 0,
                                          totalDeaths: snapshot.data![index]['deaths'] ?? 0,
                                          active: snapshot.data![index]['active'] ?? 0,
                                          test: snapshot.data![index]['test'] ?? 0,
                                          totalRecovered: snapshot.data![index]['todayRecovered'] ?? 0,
                                          critical: snapshot.data![index]['critical'] ?? 0,

                                        )));
                                      },
                                      child: ListTile(
                                        title: Text(snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]['cases'].toString()),
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(snapshot.data![index]['countryInfo']['flag']
                                            )),
                                      ),
                                    )

                                  ],

                                );
                              }
                            else if(name.toLowerCase().contains(searchController.text.toLowerCase()))
                              {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          name: snapshot.data![index]['country'],
                                          totalCases: snapshot.data![index]['cases'] ?? 0,
                                          todayRecovered: snapshot.data![index]['recovered'] ?? 0,
                                          totalDeaths: snapshot.data![index]['deaths'] ?? 0,
                                          active: snapshot.data![index]['active'] ?? 0,
                                          test: snapshot.data![index]['test'] ?? 0,
                                          totalRecovered: snapshot.data![index]['todayRecovered'] ?? 0,
                                          critical: snapshot.data![index]['critical'] ?? 0,

                                        )));

                                      },
                                      child: ListTile(
                                        title: Text(snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]['cases'].toString()),
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(snapshot.data![index]['countryInfo']['flag']
                                            )),
                                      ),
                                    )

                                  ],

                                );
                              }
                            else
                              {
                                return Container();

                              }


                        });

                      }


                    },
                  ),
              )
            ],
          ),
      ),
    );
  }
}
