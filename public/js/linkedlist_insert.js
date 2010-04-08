function Node(v,n) {
    this.value = v
    this.next = n
}

var t = new Node(3,null)
var f = new Node(6,t)
var r = new Node(2,f)
var h = new Node(10,r)

function insert(head, node) {
    if (head.next == null) { return node }
    
    var tmp = head
    while (head.next) {
        if (node.value > head.value) {
            var a = head.next
            node.next = head.next
            head.next = node
        }
        head = head.next
    }
    return tmp
}

var n = new Node(5,null)
var linked_list = insert(h,n)

// h(10)-> r(2)-> f(6)-> t(3)






