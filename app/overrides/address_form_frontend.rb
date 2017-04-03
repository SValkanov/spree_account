Deface::Override.new(virtual_path: "spree/address/_form",
                     name: "replace_form",
                     replace: "[data-hook='shipping_inner']",
                     text:
                        '
                          <p class="form-group" id=<%="#{address_id}firstname" %>>
                            <%= form.label :firstname do %>
                              <%= Spree.t(:first_name) %><abbr class="required" title="required">*</abbr>
                            <% end %>
                            <%= form.text_field :firstname, :class => "form-control required" %>
                          </p>
                          <p class="form-group" id=<%="#{address_id}lastname" %>>
                            <%= form.label :lastname do %>
                              <%= Spree.t(:last_name) %><abbr class="required" title="required">*</abbr>
                            <% end %>
                            <%= form.text_field :lastname, :class => "form-control required" %>
                          </p>
                          <% if Spree::Config[:company] %>
                            <p class="form-group" id=<%="#{address_id}company" %>>
                              <%= form.label :company, Spree.t(:company) %>
                              <%= form.text_field :company, :class => "form-control" %>
                            </p>
                          <% end %>
                          <p class="form-group" id=<%="#{address_id}address1" %>>
                            <%= form.label :address1 do %>
                              <%= Spree.t(:street_address) %><abbr class="required" title="required">*</abbr>
                            <% end %>
                            <%= form.text_field :address1, :class => "form-control  required" %>
                          </p>
                          <p class="form-group" id=<%="#{address_id}address2" %>>
                            <%= form.label :address2, Spree.t(:street_address_2) %>
                            <%= form.text_field :address2, :class => "form-control" %>
                          </p>
                          <p class="form-group" id=<%="#{address_id}city" %>>
                            <%= form.label :city do %>
                              <%= Spree.t(:city) %><abbr class="required" title="required">*</abbr>
                            <% end %>
                            <%= form.text_field :city, :class => "form-control required" %>
                          </p>
                          <p class="form-group" id=<%="#{address_id}country" %>>
                            <%= form.label :country_id do %>
                              <%= Spree.t(:country) %><abbr class="required" title="required">*</abbr>
                            <% end %>
                            <span id=<%="#{address_id}country-selection" %>>
                              <%= form.collection_select :country_id, available_countries, :id, :name, {}, {:class => "form-control required"} %>
                            </span>
                          </p>

                          <% if Spree::Config[:address_requires_state] and address.country%>
                            <p class="form-group" id=<%="#{address_id}state" %>>
                              <%# have_states = !address.country.states.empty? %>
                              <%= form.label :state do %>
                                <%= Spree.t(:state) %><abbr class="required" title="required" id=<%="#{address_id}state-required"%>>*</abbr>
                              <% end %>

                              <%=
                                 form.collection_select(:state_id, Spree::Country.find_by(name: "Bulgaria").states,
                                                    :id, :name,
                                                    {include_blank: true})
                              %>
                            </p>
                              <noscript>
                                <%= form.text_field :state_name, :class => "form-control required" %>
                              </noscript>
                          <% end %>

                          <p class="form-group" id=<%="#{address_id}zipcode" %>>
                            <%= form.label :zipcode do %>
                              <%= Spree.t(:zip) %><% if address.require_zipcode? %><abbr class="required" title="required">*</abbr><% end %>
                            <% end %>
                            <%= form.text_field :zipcode, :class => "form-control #{"required" if address.require_zipcode?}" %>
                          </p>
                          <p class="form-group" id=<%="#{address_id}phone" %>>
                            <%= form.label :phone do %>
                              <%= Spree.t(:phone) %><% if address.require_phone? %><abbr class="required" title="required">*</abbr><% end %>
                            <% end %>
                            <%= form.phone_field :phone, :class => "form-control #{"required" if address.require_phone?}" %>
                          </p>
                          <% if Spree::Config[:alternative_shipping_phone] %>
                            <p class="form-group" id=<%="#{address_id}altphone" %>>
                              <%= form.label :alternative_phone, Spree.t(:alternative_phone) %>
                              <%= form.phone_field :alternative_phone, :class => "form-control" %>
                            </p>
                          <% end %>
                        ')
