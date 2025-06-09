import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:apicoinmarketcap_1/domain/entities/core/request_state_entity.dart';
import 'package:apicoinmarketcap_1/domain/entities/moeda/moeda_entity.dart';
import 'package:apicoinmarketcap_1/ui/pages/home/view_models/tela_home_viewmodel.dart';
import 'package:apicoinmarketcap_1/utils/util_format.dart';
import 'package:apicoinmarketcap_1/configs/factory_viewmodel.dart';
import 'package:apicoinmarketcap_1/utils/util_text.dart';

class HomeWidgets extends StatefulWidget {
  const HomeWidgets({super.key});

  @override
  State<HomeWidgets> createState() => _HomeWidgetsState();
}

class _HomeWidgetsState extends State<HomeWidgets> {
  late final TelaHomeViewModel _TelaHomeViewModel;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _TelaHomeViewModel = context.read<TelaHomeViewModel>();
    _TelaHomeViewModel.pegarMoeda();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    labelText: 'Buscar criptomoeda',
                    labelStyle: const TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: _buscarMoeda,
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 150, 136),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text('PESQUISAR', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Divider(thickness: 1.5, color: Colors.grey.shade400),
          const SizedBox(height: 15),
          Expanded(
            child: BlocBuilder<TelaHomeViewModel, IRequestState<List<Cripto>>>(
              builder: (context, state) {
                if (state is RequestProcessingState) {
                  return const Center(child: CircularProgressIndicator(color: Colors.teal));
                }

                if (state is RequestCompletedState) {
                  final listaMoedas = state.data;
                  return RefreshIndicator(
                    color: Colors.teal,
                    onRefresh: () async {
                      _TelaHomeViewModel.pegarMoeda();
                    },
                    child: ListView.builder(
                      itemCount: listaMoedas.length,
                      itemBuilder: (context, index) {
                        final moeda = listaMoedas[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(2),
                          onTap: () => _mostrarDetalhesMoeda(context, moeda),
                          child: CamposDaMoeda(
                            nome: moeda.name,
                            sigla: moeda.symbol,
                            valorUSD: formatadorUSD.format(moeda.price),
                            valorBRL: formatadorBRL.format(moeda.price * 5.73),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const Center(child: Text('Moeda não encontrada!'));
              },
            ),
          ),
        ],
      ),
    );
  }

  void _buscarMoeda() {
    final symbols = formatarSimbolos(_controller.text);
    final lista = symbols.isEmpty ? todasMoedas : symbols;
    _TelaHomeViewModel.buscarMoeda(lista);
  }
}

class CamposDaMoeda extends StatelessWidget {
  final String nome;
  final String sigla;
  final String valorUSD;
  final String valorBRL;

  const CamposDaMoeda({
    super.key,
    required this.nome,
    required this.sigla,
    required this.valorUSD,
    required this.valorBRL,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      elevation: 3,
      shadowColor: const Color.fromARGB(66, 0, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nome, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(sigla, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('USD: $valorUSD', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                      Text('BRL: $valorBRL', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _mostrarDetalhesMoeda(BuildContext context, Cripto moeda) {
  final formatadorUSD = NumberFormat.currency(locale: 'en_US', symbol: 'US\$');
  final formatadorBRL = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(moeda.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 150, 136))),
            const SizedBox(height: 12),
            Text('Símbolo: ${moeda.symbol}'),
            Text('Data adicionada: ${formatarData(moeda.date_added)}'),
            const SizedBox(height: 16),
            Text('Preço USD: ${formatadorUSD.format(moeda.price)}'),
            Text('Preço BRL: ${formatadorBRL.format(moeda.price * 5.73)}'),
          ],
        ),
      );
    },
  );
}