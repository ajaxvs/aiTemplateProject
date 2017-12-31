package app.utils.tests
{
	import app.CajApp;

	public class CajTests
	{
		//================================================================================
		public function CajTests() {}
		//================================================================================
		/**
		 * @return true if all is ok. False == app exit. 
		 */
		static public function tests():Boolean {
			var ret:Boolean = true;
			
			ret = testData() &&
				  testLogic() &&
				  
				  true;			
			
			return ret;
		}
		//================================================================================
		static private function testData():Boolean {
			var ret:Boolean = true;

			if (2 + 2 != 4) {
				CajApp.log.add("A0", 4);
				ret = false;
			}			
			
			return ret;
		}
		//================================================================================
		static private function testLogic():Boolean {
			var ret:Boolean = true;
			
			if (2 * 2 != 4) {
				CajApp.log.add("B0", 4);
				ret = false;
			}			
			
			return ret;
		}
		//================================================================================
	}
}