var JMap = function (obj)
{
 var mapData = (obj != null) ? cloneObject(obj) : new Object();
 
 this.put = function(key, value)
 {
  mapData[key] = value;  
 };
 
 this.get = function(key)
 {
  return mapData[key];  
 };
 
 this.remove = function(key)
 {
  for(var tKey in mapDate)
  {
   if(tKey == key)
   {
    delete mapData[yKey];
    break;
   }
  }
 };
 
 this.clear = function()
 {
  for(var key in mapData)
  {
   delete mapDate[key];
  }
 };
 
 this.size = function()
 {
  var size = 0;
  for(var key in mapData)
  {
   size++;
  }
  return size;
 };

 var cloneObject = function(obj)
 {
  var cloneObj = {};
  for(var attrName in obj)
  {
   cloneObj[attrName] = obj[attrName];  
  }  
  return cloneObj;
 }
}
