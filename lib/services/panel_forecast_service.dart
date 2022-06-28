import 'dart:math' as math;
import 'package:panel_forecast/models/basic_parameters_model.dart';
import 'package:panel_forecast/models/parameters_model.dart';
import 'package:panel_forecast/models/weather_parameters_model.dart';
import 'package:panel_forecast/services/day_of_year_dependent_values.dart';
import 'package:jiffy/jiffy.dart';
import 'package:vector_math/vector_math.dart';
class PanelForecastService {
   
  

  static double forecastPowerProduction(BasicParametersModel basicParameters, List<ParametersModel> listParametersModel, WeatherParametersModel weatherParametersModel) {
    double power = 0;
    double powerCalculatedByModel = 0;
    switch (weatherParametersModel.model) {
      case 'MODEL_P_MAX_2_EQU_1_21' : {
          powerCalculatedByModel = _forecastPowerProductionModelPmax2(basicParameters,listParametersModel,weatherParametersModel);
      }  
        break;
      case 'MODEL_P_MAX_4_EQU_1_21' : {
          powerCalculatedByModel = _forecastPowerProductionModelPmax4(basicParameters,listParametersModel,weatherParametersModel);
      }
      break;
      case 'MODEL_FUZZY_NMF_EQU_2_24' : {
        powerCalculatedByModel = _forecastPowerProductionModelFuzzyNMF(basicParameters,listParametersModel,weatherParametersModel);
      }
      break;
    }
    power = powerCalculatedByModel * basicParameters.surface * basicParameters.inverterEfficeincy;
    return power;
  }
  static double _forecastPowerProductionModelPmax2(BasicParametersModel basicParameters, List<ParametersModel> listParametersModel, WeatherParametersModel weatherParametersModel){
    ParametersModel parametersModel = listParametersModel.firstWhere((element) => element.name == 'MODEL_P_MAX_2_EQU_1_21');
    double result =0;
    double a = parametersModel.parameters['a'];
    double b = parametersModel.parameters['b'];
    double c = parametersModel.parameters['c'];
    double d = parametersModel.parameters['d'];
    double e = parametersModel.parameters['e'];
    double irradiationInPanelSurface = _calculateIrradiationInPanelSurface(basicParameters, weatherParametersModel);

    result = e;
    result += a * math.pow(weatherParametersModel.temperature, 0.0) * math.pow(irradiationInPanelSurface, 2.0);
    result += b * math.pow(weatherParametersModel.temperature, 1.0) * math.pow(irradiationInPanelSurface, 1.0);
    result += c * math.pow(weatherParametersModel.temperature, 0.0) * math.pow(irradiationInPanelSurface, 1.0);
    result += d * math.pow(weatherParametersModel.temperature, 1.0) * math.pow(irradiationInPanelSurface, 0.0);

    return result;
  }
  static double _forecastPowerProductionModelPmax4(BasicParametersModel basicParameters, List<ParametersModel> listParametersModel, WeatherParametersModel weatherParametersModel){
    ParametersModel parametersModel = listParametersModel.firstWhere((element) => element.name == 'MODEL_P_MAX_4_EQU_1_21');
    double result =0;
    double c1 = parametersModel.parameters['c1'];
    double c2 = parametersModel.parameters['c2'];
    double c3 = parametersModel.parameters['c3'];
    double c4 = parametersModel.parameters['c4'];
    double c5 = parametersModel.parameters['c5'];
    double c6 = parametersModel.parameters['c6'];
    
    double irradiationInPanelSurface = _calculateIrradiationInPanelSurface(basicParameters, weatherParametersModel);

    result = c6;
    result += c1 * math.pow(weatherParametersModel.temperature, 0.0) * math.pow(irradiationInPanelSurface, 3.0);
    result += c2 * math.pow(weatherParametersModel.temperature, 0.0) * math.pow(irradiationInPanelSurface, 2.0);
    result += c3 * math.pow(weatherParametersModel.temperature, 1.0) * math.pow(irradiationInPanelSurface, 2.0);
    result += c4 * math.pow(weatherParametersModel.temperature, 1.0) * math.pow(irradiationInPanelSurface, 0.0);
    result += c5 * math.pow(weatherParametersModel.temperature, 0.0) * math.pow(irradiationInPanelSurface, 1.0);
    return result;
  }
   static double _forecastPowerProductionModelFuzzyNMF(BasicParametersModel basicParameters, List<ParametersModel> listParametersModel, WeatherParametersModel weatherParametersModel){
      ParametersModel parametersModel = listParametersModel.firstWhere((element) => element.name == 'MODEL_FUZZY_NMF_EQU_2_24');
    double result = 0;
    double n1 = parametersModel.parameters['n1'];
    double n2 = parametersModel.parameters['n2'];
    double n3 = parametersModel.parameters['n3'];
    double n4 = parametersModel.parameters['n4'];
    double n5 = parametersModel.parameters['n5'];
    double n6 = parametersModel.parameters['n6'];
    double n7 = parametersModel.parameters['n7'];
    double n8 = parametersModel.parameters['n8'];
    double n9 = parametersModel.parameters['n9'];
    
    double irradiationInPanelSurface = _calculateIrradiationInPanelSurface(basicParameters, weatherParametersModel);

    result = n9;
    result += n1 * math.pow(weatherParametersModel.temperature, 2.0) * math.pow(irradiationInPanelSurface, 2.0);
    result += n2 * math.pow(weatherParametersModel.temperature, 2.0) * math.pow(irradiationInPanelSurface, 1.0);
    result += n3 * math.pow(weatherParametersModel.temperature, 2.0) * math.pow(irradiationInPanelSurface, 0.0);
    result += n4 * math.pow(weatherParametersModel.temperature, 1.0) * math.pow(irradiationInPanelSurface, 2.0);
    result += n5 * math.pow(weatherParametersModel.temperature, 1.0) * math.pow(irradiationInPanelSurface, 1.0);
    result += n6 * math.pow(weatherParametersModel.temperature, 1.0) * math.pow(irradiationInPanelSurface, 0.0);
    result += n7 * math.pow(weatherParametersModel.temperature, 0.0) * math.pow(irradiationInPanelSurface, 2.0);
    result += n8 * math.pow(weatherParametersModel.temperature, 0.0) * math.pow(irradiationInPanelSurface, 1.0);

    return result;
   }
   static DayOfYearDependendValues _calculateValues(WeatherParametersModel weatherParametersModel){
    double twoGamma;
    int dayOfYear = Jiffy(weatherParametersModel.dateTime).dayOfYear;
    DayOfYearDependendValues result = DayOfYearDependendValues();

    result.gamma = radians(360.0 / 365.0 * (dayOfYear.toDouble() - 1.0));
    twoGamma = 2.0 * result.gamma;
    result.sinGamma  = math.sin(result.gamma);
    result.sin2Gamma = math.sin(twoGamma);
    result.cosGamma = math.cos(result.gamma);
    result.cos2gamma = math.cos(twoGamma);
    result.oneDivDPow2 = 1.00011 + 0.034221 * result.cosGamma +0.00128 * result.sinGamma + 0.000719 * result.cosGamma +0.00077 * result.sin2Gamma;
    result.delta = radians((180.0/math.pi) *
     (0.006918 - 0.399912 * result.cosGamma + 0.070257 * result.sinGamma - 0.006758 * result.cos2gamma + 0.000907 * result.sin2Gamma-0.002697
      * math.cos(3.0 * result.gamma)+0.00148 * math.sin(3.0 * result.gamma)));


    return result;
   }
   static double _calculateIrradiationInPanelSurface(BasicParametersModel basicParameters, WeatherParametersModel weatherParametersModel){
    double result = 0;


    DayOfYearDependendValues calculatedValues = _calculateValues(weatherParametersModel);
    double phi, s, sigma, a1, omegaS, gOd, gTd;
    double a, b, ab, aPow2Plus1, alphaT, a2, a3, a4, omegaST, omegaRT;
    double rb1, rb2, rb3, rb4, rb4second, rb5, rb, k;
    bool c1, c2, c3;
    double dd, bd, rr, rdLJ, rd, cosS, sinS, sinDelta, cosDelta;

    phi = basicParameters.latitude;
    sigma = basicParameters.albedo;
    s = basicParameters.tiltAngle;
    cosS = math.cos(s);
    sinS = math.sin(s);
    sinDelta = math.sin(calculatedValues.delta);
    cosDelta = math.cos(calculatedValues.delta);
    a1 = - math.tan(calculatedValues.delta) * math.tan(phi);
    if(a1.abs()< 1.0) {
            omegaS = math.acos(a1);
        } else {
            if(calculatedValues.delta * phi > 0.0 ) {
                omegaS = 180.0;
            } else {
                omegaS = 0.0;
            }
        }
    gOd = 37.595 * calculatedValues.oneDivDPow2 * (math.sin(phi) * sinDelta*omegaS + math.cos(phi)*cosDelta * math.sin(omegaS));
    alphaT = radians(0.5);
    a = math.cos(phi) / (math.sin(alphaT) * math.tan(s)) + math.sin(phi) / math.tan(alphaT);
    b = math.tan(calculatedValues.delta) * (cosDelta / math.tan(alphaT) - sinDelta / (math.sin(alphaT) * math.tan(s)));
    ab = a * b;
    aPow2Plus1 = a*a + 1.0;
    a2 = math.sqrt(a*a-b*b + 1.0);
    a3 = (ab - a2)/aPow2Plus1;
    a4 = (ab + a2)/aPow2Plus1;
    omegaST = math.min(omegaS, math.acos(a4));
    omegaRT = - math.min(omegaS, math.acos(a3));
    // equ 7 from DOI 10.1007/s00704-005-0171-y
    rb1 = cosS * sinDelta * math.sin(phi) * (omegaST - omegaRT);
    rb2 = sinDelta * math.cos(phi) * sinS * math.cos(alphaT)*(omegaST - omegaRT);
    rb3 = math.cos(phi) * cosDelta * cosS * (math.sin(omegaST) - math.sin(omegaRT));
    rb4 = cosDelta * math.cos(alphaT) * math.sin(phi) * sinS * (math.sin(omegaST) - math.sin(omegaRT));
    rb4second = cosDelta * sinS * math.sin(omegaS) * (math.cos(omegaST) - math.cos(omegaRT));
    rb5 = 2.0 * (math.cos(phi) * cosDelta * math.sin(omegaS) + omegaS * sinDelta * math.sin(phi));
    rb = (rb1 - rb2 + rb3 + rb4 + rb4second) / rb5;
    // equ A.5 from DOI 10.1007/s00704-005-0171-y
    k = weatherParametersModel.irradiation / (1000000.0 * gOd);
    c1 = k <= 0.13;
    c2 = false;
    if(k > 0.13 && k <= 0.80) {
        c2 = true;
    }
    c3 = false;
    if(k > 0.80) {
        c3 = true;
    }
    dd = double.nan;
    if(c1) {
        dd = 0.952;
    }
    if(c2) {
        dd = 0.867 + 1.335 * k - 5.782 * k*k + 3.721 * k*k*k;
    }
    if(c3) {
        dd = 0.141;
    }
    dd = dd * weatherParametersModel.irradiation;
    bd = weatherParametersModel.irradiation - dd;
    rr = sigma * (1-math.cos(s))/2.0;
    rdLJ = (1+math.cos(s))/2.0;
    switch(basicParameters.model) {
        case 'BADESCU':
            rd = (3.0 + math.cos(2.0 * s))/4.0;
            break;
        case 'HAY':
            rd = bd / (gOd * 1000000.0) * rb + (1 - bd / (gOd * 1000000.0))*rdLJ;
            break;
        case 'KORONAKIS':
            rd = 1.0 / 3.0 * (2.0 + math.cos(s));
            break;
        case 'LIU_JORDAN':
            rd = rdLJ;
            break;
        case 'REINDL':
            rd = bd / (gOd * 1000000.0) * rb + (1 - bd / (gOd * 1000000.0)) * rdLJ*(1 + math.sqrt(bd/weatherParametersModel.irradiation) * math.pow(math.sin(s/2.0),3.0));
            break;
        case 'STEVEN_UNSWORTH':
            rd = 0.51 * rb + rdLJ - (1.74/(1.26 * math.pi))*(sinS-(s*math.pi/180.0)*cosS-math.pi*math.pow(math.sin(s/2.0), 2.0));
            break;
        case 'TIAN':
            rd = 1.0 - degrees(s)/180.0;
            break;
        default:
            throw  Exception("Unknown diffuse radiation model");
    }
    gTd = rb * bd + rd * dd + rr * weatherParametersModel.irradiation; // it is in [Ws/m^2]
    gTd = gTd/(60.0 * 60.0); // [Wh/m^2]
    result = gTd;



    return result;

   }
}
