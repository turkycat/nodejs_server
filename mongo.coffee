assert = require "assert"
mongo = require "mongodb"
    .MongoClient
root = exports ? this       #wow, this is a cool trick. automatically compiles to ternary which returns itself if true, this otherwise
    
url = "mongodb://localhost:27017/nodejs_server"
root.db = null

open_database = () ->
    mongo.connect url, ( err, db ) ->
        assert.equal null, err
        root.db = db
        console.log( "connected to server" )
        
close_database = () ->
    root.db.close()
    root.db = null
    
insert_documents = ( docs ) ->
    assert.notEqual root.db, null
    collection = root.db.collection "documents"
    cb = ( err, result ) ->
        assert.equal err, null
        #assert.equal docs.length, result.result.n
        #assert.equal docs.length, result.ops.length
        console.log "inserted #{result.result.n} documents into the document collection"
    #if typeof docs.length is "undefined" || docs.length == 1 then collection.insertOne docs, cb else collection.insertMany docs, cb        #doesn't work, insertOne needs to be an object
    if typeof docs.length is "undefined"
        collection.insertOne docs, cb
    else if docs.length == 1
        collection.insertOne docs[0], cb
    else if docs.length > 1
        collection.insertMany docs, cb
    else
        console.log "invalid document entry, database not modified"
        
delete_documents = ( doc ) ->
    assert.notEqual root.db, null
    collection = root.db.collection "documents"
    collection.deleteMany doc, ( err, result ) ->
        assert.equal err, null
        #assert.equal docs.length, result.result.n
        #assert.equal docs.length, result.ops.length
        console.log "deleted #{result.result.n} documents from the document collection"
        
documents = [{
        name:   "Jesse Frush"
        age:    28
        ssn:    "555-55-5555"
    },{
        name:   "Apu Dutta"
        age:    22
        ssn:    "111-222-3333"
    },{
        name:   "Ash"
        age:    34
        ssn:    "555-66-7777"
    }]
    
onedoc = [{
        name:   "Jesse Frush"
        age:    28
        ssn:    "555-55-5555"
    }]

open_database()

#setTimeout close_database, 1000        #setTimeout was necessary because the connection wasn"t yet open when this function was called.

#setTimeout insert_documents.bind( null, onedoc ), 2000
setTimeout insert_documents.bind( null, documents ), 2000
#setTimeout insert_documents.bind( null, documents[0] ), 2000               #this doesn't work because insertMany must be an array of items
#setTimeout delete_documents.bind( root, { name: "Apu Dutta" } ), 2000      #this works
#setTimeout delete_documents.bind( root, { "name": "Jesse Frush" } ), 2000  #so does this
#setTimeout delete_documents.bind( root, documents[2] ), 2000
    

setTimeout close_database, 10000
    