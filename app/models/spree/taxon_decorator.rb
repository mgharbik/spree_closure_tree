Spree::Taxon.class_eval do
  has_closure_tree hierarchy_class_name: 'Spree::TaxonHierarchy',
                   hierarchy_table_name: 'spree_taxon_hierarchies',
                   order: 'position'

  def move_to_child_with_index(node, index)
    if node.children.empty? || node.children.count == index
      node.append_child(self)
    else
      my_position = node.children.index(self)
      if my_position && my_position < index
        node.children[index].append_sibling(self)
      elsif my_position && my_position == index
        # do nothing. already there.
      else
        node.children[index].prepend_sibling(self)
      end
    end
  end
end
