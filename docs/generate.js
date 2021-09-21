const json2html = require('node-json2html');
const JSONtemplate = require('./template.json')
const locale = require('../locale/locale.json')

// bad way to deep clone, but better then notthing
const localizedTree = JSON.parse(JSON.stringify(JSONtemplate))

for (let i = 0; i < localizedTree.length; i++) {
  const element = localizedTree[i];
  for (let j = 0; j < element.tree.length; j++) {
    const _tree = element.tree[j];
    for (let h = 0; h < _tree.length; h++) {
      const _treeEl = _tree[h];
      _treeEl.name = locale[_treeEl.name]
      _treeEl.desc = locale[_treeEl.desc]
    }
  }
}

console.log(localizedTree)

const skillTemplate = {"<>":"div","class":"skill","html":[
  {"<>":"span","class":"name","html":" ${name} "},
  {"<>":"span","class":"desc","html":" ${desc} "}
]}

let html = json2html.transform(localizedTree[0].tree,skillTemplate);

console.log(html)
console.log('Done')