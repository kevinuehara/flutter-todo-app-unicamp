const express = require("express");

const app = express();
var cors = require("cors");
app.use(cors());

const mongodb = require("mongodb");
const ObjectId = mongodb.ObjectId;
const connectionString = `mongodb+srv://kevin:123@cluster0.klifq.mongodb.net/taskDB?retryWrites=true&w=majority`;

const options = {
  useNewUrlParser: true,
  useUnifiedTopology: true,
};

var server = require('http').createServer(app);
server.listen(3000);


async function connectToMongoDB() {
  const client = await mongodb.MongoClient.connect(connectionString, options);
  const db = client.db("tasksDB");
  const mensagens = db.collection("tasks");
  const endpoint = "/tasks";


  app.use(express.json());

  app.get(endpoint, async (req, res) => {
    res.send(await mensagens.find({}).toArray());
  });

  app.get(`${endpoint}/:id`, async (req, res) => {
    const id = req.params.id;
    const task = await mensagens.findOne({
      _id: ObjectId(id),
    });

    if (task) {
      res.send(task);
    } else {
      res.send("{}");
    }
  });

  app.post(endpoint, async (req, res) => {
    const task = {
      title: req.body["title"],
      description: req.body["description"],
      done: req.body["done"],
      createdAt: new Date(Date.now()).toISOString()
    };

    const id = await mensagens.insertOne(task);
    res.send({ id: id.insertedId.toString(), ...task });
  });

  app.put(`${endpoint}/:id`, async (req, res) => {
    const id = req.params.id;
    console.log('updated')
    const task = {
      title: req.body["title"],
      description: req.body["description"],
      done: req.body["done"],
    };

    await mensagens.updateOne({ _id: ObjectId(id) }, { $set: task });

    res.send({ id, ...task });
  });

  app.delete(`${endpoint}/:id`, async (req, res) => {
    const id = req.params.id;
    console.log(id);
    await mensagens.deleteOne({ _id: ObjectId(id) });

    res.send({ id });
  });
}

connectToMongoDB();
