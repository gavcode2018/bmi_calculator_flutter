import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/icon_content.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import '../constants.dart';
import 'results_page.dart';
import '../components/bottom_button.dart';
import '../components/RoundIconButton.dart';
import 'package:bmi_calculator/calculator_brain.dart';


enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  Color maleCardColour = kInactiveCardColor;
  Color femaleCardColour = kInactiveCardColor;
  Gender? selectedGender;
  int height = 180;
  int weight =60;
  int age=25;

 // get onPressed => null;

  //1=male 2=female
  // void updateColor(Gender selectedGender) {
  //
  //
  //
  //   if (selectedGender==Gender.male){
  //     if (maleCardColour== inactiveCardColor){
  //       maleCardColour=activeCardColor;
  //       femaleCardColour=inactiveCardColor;
  //     }else {
  //       maleCardColour=inactiveCardColor;
  //     }
  //   }
  //   if (selectedGender==Gender.female){
  //     if (femaleCardColour==inactiveCardColor){
  //       femaleCardColour=activeCardColor;
  //       maleCardColour=inactiveCardColor;
  //     }else {
  //       femaleCardColour=inactiveCardColor;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: Row(
            children: <Widget>[
              Expanded(
                child: reusableCard(
                  onPress: (){
                    setState(() {
                      selectedGender= Gender.male;
                    });
                  } ,
                colour:selectedGender==Gender.male? kActiveCardColor: kInactiveCardColor,
                cardChild: IconContent(
                  icon: FontAwesomeIcons.mars,
                  label: 'MALE',),
                ),
              ),
              Expanded(
                child: reusableCard(
                  onPress: (){
                    setState(() {
                      selectedGender= Gender.female;
                    });
                  },
                colour: selectedGender==Gender.female? kActiveCardColor:kInactiveCardColor,
                cardChild: IconContent(
                  icon: FontAwesomeIcons.venus,
                  label: 'FEMALE',),
              ),
              ),
            ],
          )),
          Expanded
            (child: reusableCard(
              colour: kActiveCardColor,
              cardChild: Column(
                children: <Widget>[
                  Text(
                    'Height',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        style:kNumberTextStyle
                      ),
                      Text (
                        'cm',
                        style: kLabelTextStyle,
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Color(0xFF8D8E98),
                      activeTrackColor: Colors.white,
                      thumbColor: Color(0xFFEB1555),
                      overlayColor: Color(0x29EB1555),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                    ),
                    child: Slider(
                        value: height.toDouble(),
                        min: 120.0,
                        max: 220.0,
                        onChanged: (double newValue) {
                          setState(() {
                            height= newValue.round();
                          });

                        }
                    ),
                  ),

                ],
              ),
            ),
          ),
          Expanded(child: Row(
            children: <Widget>[
              Expanded(
                child: reusableCard(
                  colour: kActiveCardColor,
                  cardChild: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Weight',
                        style: kLabelTextStyle,
                      ),
                      Text(
                        weight.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: (){
                              setState(() {
                                weight--;
                              });
                            },
                          ),
                          SizedBox(width: 10.0),
                          RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: (){
                              setState(() {
                                weight++;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: reusableCard(
                  colour: kActiveCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text (
                        'AGE',
                        style: kLabelTextStyle,
                      ),
                      Text(
                        age.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: (){
                                setState(() {
                                  age--;
                                });
                              },
                          ),


                          SizedBox(width: 10.0),
                          RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: (){
                                setState(() {
                                  age++;
                                });
                              },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          ),
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: (){
              CalculatorBrain calc = CalculatorBrain(height: height, weight: weight);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context){
                    return ResultsPage(
                      bmiResult: calc.calculateBMI() ,
                      resultText: calc.getResult(),
                      interpretation: calc.getInterpretation() ,
                    );
                  },
                ),
              );
            },
          )
        ],
      )
    );
  }
}







