/*
*   This class handles the trigger execution.
*/
public class TriggerHandler
{
    /*
     *   The method runs the trigger layers basing on the object and the trigger context.
     *   The context is given by Trigger.operationType: a standard enum with values BEFORE_INSERT, BEFORE_UPDATE...
     *   The object and the context are used as filters for the query to recover the layers. 
     *
     *   @param objType The object of the trigger given as SObjectType. For example, Account.SObjectType.
     *       String.valueOf(objType) gives the API name of the object as a string.
     */
    public static void run(SObjectType objType) {
        String objTypeStr = String.valueOf(objType);
        String trigContext = String.valueOf(Trigger.operationType);
        String warningMsg = 'WARNING in ' + trigContext + ' trigger on ' + objTypeStr + '. ';
        String errorMsg = 'ERROR in ' + trigContext + ' trigger on ' + objTypeStr + '. ';
        // The records are ordered to enforce the correct execution. Inactive layers are not considered
        List<Trigger_Layer_Table__mdt> trigLayers = [SELECT DeveloperName,
                                                     Apex_Class__c,
                                                     is_Active__c,
                                                     Execution_Order__c
                                                     FROM Trigger_Layer_Table__mdt
                                                     WHERE Object__c = :objTypeStr
                                                     AND Context__c = :trigContext
                                                     AND is_Active__c = true
                                                     ORDER BY Execution_Order__c ASC];
        if (trigLayers != null && !trigLayers.isEmpty()) {
            for (Trigger_Layer_Table__mdt tlRecord : trigLayers) {
                try {
                    // Istantiate the proper class by the class field of the record of the custom metadata
                    TriggerLayer tl = (TriggerLayer) Type.forName(tlRecord.Apex_Class__c).newInstance();
                    tl.init(Trigger.oldMap, Trigger.newMap, Trigger.old, Trigger.new);
                    try {
                        tl.setupAndExecute();
                    } catch(Exception e) {
                        System.debug(errorMsg + tlRecord.DeveloperName + ' run failed. '
                                     + e.getMessage() + '. ' + e.getStackTraceString());
                    }
                } catch(Exception e) {
                    // If the class does not exist, log an error and executes the other layers
                    System.debug(errorMsg + tlRecord.Apex_Class__c + ' class does not exist. Skipping the layer...');
                }
            }
        } else {
            System.debug(warningMsg + 'No active layers found.');
        }
    }

}
