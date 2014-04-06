- encodeURIComponent 用utf8对整个uri组件编码，即假定传进的参数作为uri的一部分（包括协议、主机名等）;
- encodeURI	用utf8对uri部分编码（不包括协议、主机名等），可用于history;
- escape 用utf8对大部分字符编码;

最多使用的应为encodeURIComponent，它是将中文、韩文等特殊字符转换成utf-8格式的url编码，所以如果给后台传递参数需要使用encodeURIComponent时需要后台解码对utf-8支持（form中的编码方式和当前页面编码方式相同）

> escape 不编码字符有69个：*，+，-，.，/，@，_，0-9，a-z，A-Z
> encodeURI 不编码字符有82个：!，#，$，&，'，(，)，*，+，,，-，.，/，:，;，=，?，@，_，~，0-9，a-z，A-Z
> encodeURIComponent 不编码字符有71个：!， '，(，)，*，-，.，_，~，0-9，a-z，A-Z
