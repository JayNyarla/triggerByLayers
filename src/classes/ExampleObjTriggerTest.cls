@isTest
private class ExampleObjTriggerTest  {

    @isTest
    static void beforeInsertTest() {
        TLayer_Example_Obj__c eo = new TLayer_Example_Obj__c(Name = 'Test object');
        insert eo;

        System.assertEquals([SELECT Id, Name FROM TLayer_Example_Obj__c].Name, 'Test object' + String.valueOf(System.today()));
    }
}