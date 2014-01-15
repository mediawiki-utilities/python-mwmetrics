from collections import namedtuple

class AbstractRowType:
	
	def __init__(self, line):
		values = line.strip("\n").split("\t")
		
		self.__dict__['_values'] = tuple(decode(v, self._types[i]) for i, v in enumerate(values))
	
	def __iter__(self):
		for header in self._headers:
			yield header
	
	def keys(self):
		return list(self._headers)
	
	def values(self):
		return list(self.__dict__['_values'])
	
	def items(self):
		return list(self.iteritems())
	
	def iteritems(self):
		for index, header in enumerate(self._headers):
			yield header, self.__dict__['_values'][index]
	
	def __getitem__(self, key_or_index):
		
		index = self._internal_index(key_or_index)
		
		return self.__dict__['_values'][index]
	
	def __setitem__(self, key_or_index):
		raise TypeError("item assignment not supported")
	
	def __getattr__(self, key):
		index = self._internal_index(key)
		
		return self.__dict__['_values'][index]
	
	def __setattr__(self, key, value):
		raise TypeError("item assignment not supported")
		
	def _internal_index(self, key_or_index):
		if type(key_or_index) == int:
			index = key_or_index
		else:
			if key_or_index not in self._headers:
				raise KeyError(key_or_index)
			else:
				index = self._headers[key_or_index]
		
		return index
	
	def __eq__(self, other):
		try:
			for p1, p2 in zip(self.iteritems(), other.iteritems()):
				if p1 != p2: return False
			
			return True
		except AttributeError:
			return False
	

def generate_row_type(headers, types=None):
	headers = list(headers)
	
	if types != None:
		assert len(types) == len(headers), \
			"Length of types {0} must match headers {1}".format(len(types),
			                                                    headers)
		
	else:
		types = [utf8 for _ in headers]
	
	class _RowType(AbstractRowType):
		_headers = dict((h, i) for i, h in enumerate(headers))
		_types = types
	
	return _RowType

def no_types(line):
	return [utf8(v) for v in line.strip("\n").split()]

class FIRST_LINE: pass

class Reader:
	
	FIRST_LINE = FIRST_LINE
	
	def __init__(self, f, headers=FIRST_LINE, types=None):
		self.f = f
		if headers == FIRST_LINE:
			headers = f.readline().strip("\n").split("\t")
		else:
			headers = []
		
		self.row_type = generate_row_type(headers, types)
		
		self.headers = headers
	
	def __iter__(self):
		for line in self.f:
			yield self.row_type(line)
		
	
class Writer:
	
	def __init__(self, f, headers=None):
		self.f = f
		
		if headers != None:
			self.f.write("\t".join(encode(h) for h in headers) + "\n")
		
	def write(self, values):
		self.f.write("\t".join(encode(v) for v in values) + "\n")
		

STRING_TYPES = {str, bytes}

def encode(val):
	if val == None: 
		return "NULL"
	elif type(val) in STRING_TYPES:
		if type(val) == bytes:
			val = val.decode('utf-8', "replace")
		
		return val.replace("\t", "\\t").replace("\n", "\\n") # .encode('utf-8')
	else:
		return str(val) # .encode('utf-8')
	
def utf8(bytes_or_str):
	if type(bytes) == bytes:
		return str(bytes, 'utf-8')
	else:
		return bytes_or_str
	
def decode(value, func=utf8):
	if value == "NULL":
		return None
	else:
		return func(value)
