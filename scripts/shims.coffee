Array.prototype.remove = (from, to) ->
    rest = this.slice((to || from) + 1 || this.length)
    this.length = from < 0 ? this.length + from : from
    return this.push.apply(this, rest)

Array.prototype.contains = (a) ->
    for i in [0 .. this.length]
        if this[i] == a
            return true
    return false

String.prototype.toDOM = ->
    div = document.createElement('div')
    div.innerHTML = this
    fragment = document.createDocumentFragment()
    while div.firstChild
        fragment.appendChild(div.firstChild)
    return fragment

`
if (!("classList" in document.documentElement) && Object.defineProperty && typeof HTMLElement !== 'undefined') {
    Object.defineProperty(HTMLElement.prototype, 'classList', {
        get: function() {
            var self = this;
            function update(fn) {
                return function(value) {
                    var classes = self.className.split(/\s+/),
                        index = classes.indexOf(value);

                    fn(classes, index, value);
                    self.className = classes.join(" ");
                }
            }

            var ret = {                    
                add: update(function(classes, index, value) {
                    ~index || classes.push(value);
                }),

                remove: update(function(classes, index) {
                    ~index && classes.splice(index, 1);
                }),

                toggle: update(function(classes, index, value) {
                    ~index ? classes.splice(index, 1) : classes.push(value);
                }),

                contains: function(value) {
                    return !!~self.className.split(/\s+/).indexOf(value);
                },

                item: function(i) {
                    return self.className.split(/\s+/)[i] || null;
                }
            };
            
            Object.defineProperty(ret, 'length', {
                get: function() {
                    return self.className.split(/\s+/).length;
                }
            });

            return ret;
        }
    });
}
`
