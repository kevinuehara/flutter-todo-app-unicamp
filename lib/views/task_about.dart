import 'package:flutter/material.dart';

class TaskAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text('Sobre nós',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ))),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
              "        O aplicativo \"TODO App\" foi desenvolvido pelos alunos Breno Reis e Kevin Uehara da Faculdade de Tecnologia da Unicamp " +
                  "como parte da proposta da disciplina SI700 - Programação para Dispositívos Móveis.\n        O foco do aplicativo é em auxiliar " +
                  "o usuário no dia a dia fornecendo uma plataforma simples e confiável para que se possa criar, alterar e remover tarefas, " +
                  "tornando facil a organização das pessoas que muitas vezes na correria da vida cotidiana se esquece desde compromissos " +
                  "importantes até mesmo tarefas simples.",
              style: TextStyle(fontSize: 18)),
        )
      ],
    ));
  }
}
