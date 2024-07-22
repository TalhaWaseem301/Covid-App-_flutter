import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/Services/states_servics.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WordStatesScreen extends StatefulWidget {


  @override
  State<WordStatesScreen> createState() => _WordStatesScreenState();
}

class _WordStatesScreenState extends State<WordStatesScreen> with TickerProviderStateMixin{


  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5), // Specify the duration here
  )..repeat();

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to free up resources
    super.dispose();
  }

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa268),
    Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServics statesServics = StatesServics();
    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01,),
              FutureBuilder(
                  future: statesServics.fetchWorldStatesRecord(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                    if(!snapshot.hasData)
                      {
                        return Expanded(
                            flex: 1,
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              size: 50.0,
                              controller: _controller,
                            ),
                        );

                      }
                    else{
                      return Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.4,
                                child: PieChart(
                                  dataMap:{
                                    "Total":double.parse(snapshot.data!.cases!.toString()),
                                    "Recovered":double.parse(snapshot.data!.recovered!.toString()),
                                    "Deaths":double.parse(snapshot.data!.deaths!.toString()),
                                  },
                                  chartValuesOptions: const ChartValuesOptions(
                                    showChartValuesInPercentage: true
                                  ),
                                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                                  legendOptions: const LegendOptions(
                                      legendPosition: LegendPosition.left
                                  ),
                                  animationDuration: const Duration(milliseconds: 1200),
                                  chartType: ChartType.ring,
                                  colorList: colorList,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Column(
                                    children: [
                                      ReusableRow(title: 'Total',value: snapshot.data!.cases.toString(),),
                                      ReusableRow(title: 'Death',value: snapshot.data!.deaths.toString(),),
                                      ReusableRow(title: 'Recovered',value: snapshot.data!.recovered.toString(),),
                                      ReusableRow(title: 'Active',value: snapshot.data!.active.toString(),),
                                      ReusableRow(title: 'Critical',value: snapshot.data!.critical.toString(),),
                                      ReusableRow(title: 'Today Deaths',value: snapshot.data!.todayDeaths.toString(),),
                                      ReusableRow(title: 'Today Recovered',value: snapshot.data!.todayRecovered.toString(),),
                          
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>  CountriesListScreen()));
    
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color(0xff1aa268),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text("Track Countries"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title,value;
   ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}

