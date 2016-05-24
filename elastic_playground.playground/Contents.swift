//: Playground - noun: a place where people can play

import Cocoa

enum LevelType{
	case root
	case nested
}

enum HttpVerb{
	case post
	case put
	case get
	case delete
}

enum ParamType{
	case boolean
	case string
	case list
}

class BodyParameter{
	var name : String
	var childParameters : [BodyParameter]?
	var level : LevelType
	var type : ParamType
	
	init(name : String, childParameters : [BodyParameter]?, level : LevelType, type : ParamType){
		self.name = name
		self.childParameters = childParameters
		self.level = level
		self.type = type
	}
}

class Path{
	var value : String
	var part : ParamType
	
	init(value : String, part : ParamType){
		self.value = value
		self.part = part
	}
}

class UrlParameter{
	var name : String
	var type : ParamType
	var acceptedValue : String?
	
	init(name : String, type : ParamType){
		self.name = name
		self.type = type
	}
	
	convenience init(name : String, type : ParamType, acceptedValue : String?){
		self.init(name : name,type : type)
		self.acceptedValue = acceptedValue
	}
}


class Head {
	var pattern : [Path]
	var params : [UrlParameter]?
	
	init(pattern : [Path], params : [UrlParameter]?){
		self.pattern = pattern
		self.params = params
	}
}


protocol Api {
	var verb : HttpVerb {get}
	var url : Head {get}
	var parameter : [BodyParameter]? {get}
}


class ElasticApi<T> : Api {
	var _verb : HttpVerb
	var verb : HttpVerb {
		get {
			return _verb
		}
	}
	var _url : Head
	var url : Head {
		get{
			return _url
		}
	}
	var _parameter : [BodyParameter]?
	var parameter: [BodyParameter]?{
		get{
			return _parameter
		}
	}
	
	init(verb : HttpVerb, url : Head, parameter : [BodyParameter]?){
		self._verb = verb
		self._url = url
		self._parameter = parameter
	}
}
