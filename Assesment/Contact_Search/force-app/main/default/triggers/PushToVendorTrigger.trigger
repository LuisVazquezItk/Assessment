trigger PushToVendorTrigger on Account (after update) {
	PushToVendorHelper.updateContacts(Trigger.new);
}