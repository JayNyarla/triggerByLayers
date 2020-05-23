trigger ExampleObjTrigger on TLayer_Example_Obj__c (before insert)  {

    TriggerHandler.run(TLayer_Example_Obj__c.SObjectType);
 }