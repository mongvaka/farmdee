import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../../../utils/constants.dart';

class HomeFilterDialog extends StatefulWidget {
  String sortValue;
  String orderingValue;
  final Function(String) onFilter;
  final Function(String) onSortBy;
  final Function(String) onOrdering;
  final _ordering = ["Descending", "Ascending"];
  final _orderingMap = ["DESC", "ASC"];
  final _filter = ["Client", "Lead"];
  final _sort = ["Name", "Rating","Cash Limit", "Asset Limit"];
  final _sortMap = ["clientName", "rating","totalCash", "totalAsset"];
  HomeFilterDialog({Key? key, required this.sortValue,  required this.orderingValue,required this.onFilter, required this.onSortBy, required this.onOrdering}) : super(key: key){
    sortValue = _sort[getIndex(_sortMap,sortValue)];
    orderingValue = _ordering[getIndex(_orderingMap,orderingValue)];
  }

  @override
  State<HomeFilterDialog> createState() => _HomeFilterDialogState();


}
int getIndex(List<String> sortMap, String sortValue) {
  int index = -1;
  sortMap.asMap().forEach((key, value) {
    if(value == sortValue){
      index = key;
    }
  });
  return index;
}
class _HomeFilterDialogState extends State<HomeFilterDialog> {

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.5,
      alignment: Alignment.center,
      child: ListView(
        children: [

          Row(
            children: [
              Spacer(),
              Text('Filter & Sort',style: ClientFilterDialogStyle.clientTabStyle,),
              Spacer(),
            ],
          ),
          SizedBox(height: 15,),

          Row(
            children: [
              SizedBox(width: 15,),
              Text('Type',style: TextStyle(color: BODY_TEXT_COLOR)),
            ],
          ),

          Column(
            children: <Widget>[
              SizedBox(height: 5,),


            ],
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              SizedBox(width: 15,),
              Text('Sort Order',style: TextStyle(color: BODY_TEXT_COLOR),),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 5,),

              RadioGroup<String>.builder(
                groupValue: widget.orderingValue,
                onChanged: (value) => setState(() {
                  widget.orderingValue = value ?? '';
                  widget.onOrdering(widget._orderingMap[getIndex(widget._ordering, widget.orderingValue)]);
                }),
                items:  widget._ordering,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
                activeColor: Colors.red,
              ),

            ],
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              SizedBox(width: 15,),
              Text('Sort by',style: TextStyle(color: BODY_TEXT_COLOR),),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 5,),

              RadioGroup<String>.builder(
                groupValue: widget.sortValue,
                onChanged: (value) => setState(() {
                  widget.sortValue = value ?? '';
                  widget.onSortBy(widget._sortMap[getIndex(widget._sort, widget.sortValue)]);
                }),
                items:  widget._sort,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
                activeColor: Colors.red,
              ),

            ],
          ),
        ],
      ),
    );
  }
}
class ClientFilterDialogStyle{
  static final clientTabStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w700,
      textStyle: const TextStyle(
          fontSize: 16,
          color: TEXT_COLOR,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.clip,
          decoration: TextDecoration.none));

}
