import 'package:flutter/material.dart';
import 'package:snack_swap/components/own_bottomsheet.dart';
import 'package:snack_swap/components/rounded_sheet.dart';
import 'package:snack_swap/models/trade.dart';
import 'package:snack_swap/models/user.dart';
import 'package:snack_swap/utils/auth_bloc.dart';
import 'package:snack_swap/utils/box_manager.dart';

class SwapsPage extends StatefulWidget {
  const SwapsPage({super.key});

  @override
  State<SwapsPage> createState() => _SwapsPageState();
}

class _SwapsPageState extends State<SwapsPage> {
  late User? currentUser;
  List<Trade> acceptedTrades = [];
  List<Trade> incomingRequests = [];
  List<Trade> outgoingRequests = [];

  @override
  void initState() {
    super.initState();
    currentUser = AuthBloc().currentUserValue;
    if (currentUser != null) {
      loadTrades();
    }
  }
  
  void loadTrades() {
    if (currentUser != null) {
      setState(() {
        acceptedTrades = BoxManager.getAcceptedTrades(currentUser!);
        incomingRequests = BoxManager.getPendingTrades(currentUser!);
        outgoingRequests = BoxManager.getSentPendingTrades(currentUser!);
      });
    }
  }
  
  Future<void> _acceptTrade(Trade trade) async {
    await BoxManager.acceptTrade(trade);
    loadTrades();
  }
  
  Future<void> _declineTrade(Trade trade) async {
    await BoxManager.declineTrade(trade);
    loadTrades();
  }
  
  Future<void> _cancelTrade(Trade trade) async {
    await BoxManager.cancelTrade(trade);
    loadTrades();
  }
  
  Widget _buildRecentAcceptedTradeCard() {
    if (acceptedTrades.isEmpty) {
      return const SizedBox.shrink();
    }
    
    final trade = acceptedTrades.first;
    final isUserReceiver = trade.toUser.userID == currentUser?.userID;
    final otherUser = isUserReceiver ? trade.fromUser : trade.toUser;
    final userSnack = isUserReceiver ? trade.toUserSnack : trade.fromUserSnack;
    final otherSnack = isUserReceiver ? trade.fromUserSnack : trade.toUserSnack;
    
    return Card(
      color: Colors.green[100],
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/snacks/${otherSnack.imageImgUrl}'),
              radius: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${otherUser.name} accepted your offer!',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${userSnack.name} traded for ${otherSnack.name}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTradeRequestsList() {
    if (incomingRequests.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No incoming requests'),
      );
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: incomingRequests.length,
      itemBuilder: (context, index) {
        final trade = incomingRequests[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/snacks/${trade.fromUserSnack.imageImgUrl}'),
                  radius: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${trade.fromUser.name} wants your ${trade.toUserSnack.name}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'In trade for their ${trade.fromUserSnack.name}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => _acceptTrade(trade),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => _declineTrade(trade),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildOutgoingRequestsList() {
    if (outgoingRequests.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No pending requests'),
      );
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: outgoingRequests.length,
      itemBuilder: (context, index) {
        final trade = outgoingRequests[index];
        return Card(
          color: Theme.of(context).colorScheme.primary,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(trade.toUserSnack.imageImgUrl!),
                  radius: 42,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            const TextSpan(text: 'You want to trade '),
                            TextSpan(
                              text: trade.toUserSnack.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(text: ' with '),
                            TextSpan(
                              text: trade.toUser.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(text: ' with your '),
                            TextSpan(
                              text: trade.fromUserSnack.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                       ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          backgroundColor: WidgetStatePropertyAll(Color(0xff4C6C82))
                        ),
                        child: Text("cancel", style: TextStyle(fontWeight: FontWeight.bold),),
                        onPressed: () => _cancelTrade(trade),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5C2E1F),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text("Swaps",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Expanded(
            child: RoundedSheet(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (acceptedTrades.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 8),
                          child: Text(
                            'Recent Success!',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        _buildRecentAcceptedTradeCard(),
                        const SizedBox(height: 16),
                      ],
                      
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                        child: Text(
                          'Your Requests',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      _buildOutgoingRequestsList(),
                      
                      const SizedBox(height: 16),
                      
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                        child: Text(
                          'Incoming Requests',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      _buildTradeRequestsList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: OwnBottomSheet(currentIndex: 1),
    );
  }
}
