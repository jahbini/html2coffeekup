# 
T = require 'halvalla'
module.exports = class C_html
  #pass the db entry into the class so that the classes have access to it
  constructor: (@db,@allDB)->
    return

  # 
  # section html
  # 
  html: =>
    T.raw """
import React from 'react';
import 'spectre.css/dist/spectre-exp.css';
import 'spectre.css/dist/spectre-icons.css';
import { storiesOf } from '@storybook/react';
import { withReadme } from 'storybook-readme';
import {
  Autocomplete,
  AutocompleteInput,
} from '../ui/experimentals';
import {
  Chip,
  Avatar,
  Menu,
  MenuItem,
  Tile,
  TileIcon,
  TileContent,
} from '../ui/components';
import {
  Button,
  Input,
  FormIcon,
} from '../ui/elements';
import { Container } from '../ui/layout';

import AutocompleteReadme from '../docs/Autocomplete.md';

storiesOf('Experimentals/ Autocomplete', module)
  .addDecorator(withReadme(AutocompleteReadme))
  .add('default', () =
"""
    T.raw """
(
"""
    T.tag "Container", ".p-2", =>
      T.tag "Autocomplete", =>
        T.tag "AutocompleteInput", ".is-focused", =>
          T.div ".has-icon-left", =>
            T.tag "Input", size: "sm", placeholder: "Add user here"
            T.tag "FormIcon", ".loading"
        T.tag "Menu", =>
          T.tag "MenuItem", =>
            T.a href: "/", =>
              T.tag "Tile", centered: "centered", =>
                T.tag "TileIcon", =>
                  T.tag "Avatar", size: "sm", =>
                    T.img src: "https://picturepan2.github.io/spectre/img/avatar-4.png", alt: "Steve Rogers"
                T.tag "TileContent", =>
                  T.mark => T.raw """
S
"""
                  T.raw """
teve Roger
"""
    T.raw """
))
  .add('multiselect', () =
"""
    T.raw """
(
"""
    T.tag "Container", ".p-2", =>
      T.tag "Autocomplete", =>
        T.tag "AutocompleteInput", ".is-focused", =>
          T.tag "Chip", =>
            T.raw """
Thor Odinson
"""
            T.tag "Button", color: "clear", "aria-label": "Close", role: "button"
          T.div ".has-icon-left", =>
            T.tag "Input", size: "sm", placeholder: "Add user here", value: "S"
            T.tag "FormIcon", ".loading"
        T.tag "Menu", =>
          T.tag "MenuItem", =>
            T.a href: "/", =>
              T.tag "Tile", centered: "centered", =>
                T.tag "TileContent", =>
                  T.mark => T.raw """
S
"""
                  T.raw """
teve Roger
"""
    T.raw """
))
  .add('avatars', () =
"""
    T.raw """
(
"""
    T.tag "Container", ".p-2", =>
      T.tag "Autocomplete", =>
        T.tag "AutocompleteInput", ".is-focused", =>
          T.tag "Chip", =>
            T.tag "Avatar", size: "sm", =>
              T.img src: "https://picturepan2.github.io/spectre/img/avatar-4.png", alt: "Thor Odinson"
            T.raw """
Thor Odinson
"""
            T.tag "Button", color: "clear", "aria-label": "Close", role: "button"
          T.div ".has-icon-left", =>
            T.tag "Input", size: "sm", placeholder: "Add user here", value: "S"
            T.tag "FormIcon", ".loading"
        T.tag "Menu", =>
          T.tag "MenuItem", =>
            T.a href: "/", =>
              T.tag "Tile", centered: "centered", =>
                T.tag "TileIcon", =>
                  T.tag "Avatar", size: "sm", =>
                    T.img src: "https://picturepan2.github.io/spectre/img/avatar-4.png", alt: "Steve Rogers"
                T.tag "TileContent", =>
                  T.mark => T.raw """
S
"""
                  T.raw """
teve Roger
"""
    T.raw """
))
  .add('multiline', () =
"""
    T.raw """
(
"""
    T.tag "Container", ".p-2", =>
      T.tag "Autocomplete", =>
        T.tag "AutocompleteInput", ".is-focused", =>
          T.tag "Chip", =>
            T.raw """
Thor Odinson
"""
            T.tag "Button", color: "clear", "aria-label": "Close", role: "button"
          T.tag "Chip", =>
            T.raw """
Bruce Banner
"""
            T.tag "Button", color: "clear", "aria-label": "Close", role: "button"
          T.tag "Chip", =>
            T.raw """
Steve Rogers
"""
            T.tag "Button", color: "clear", "aria-label": "Close", role: "button"
          T.tag "Chip", =>
            T.raw """
Tony Stark
"""
            T.tag "Button", color: "clear", "aria-label": "Close", role: "button"
          T.tag "Chip", =>
            T.raw """
Natasha
"""
            T.tag "Button", color: "clear", "aria-label": "Close", role: "button"
          T.tag "Chip", =>
            T.raw """
The batman
"""
            T.tag "Button", color: "clear", "aria-label": "Close", role: "button"
          T.div ".has-icon-left", =>
            T.tag "Input", size: "sm", placeholder: "Add user here", value: "S"
            T.tag "FormIcon", ".loading"
    T.raw """
))
  .add('oneline', () =
"""
    T.raw """
(
"""
    T.tag "Container", ".p-2", =>
      T.tag "Autocomplete", oneline: "oneline", =>
        T.tag "AutocompleteInput", ".is-focused", =>
          T.tag "Chip", =>
            T.raw """
Thor Odinson
"""
            T.tag "Button", color: "clear", "aria-label": "Close", role: "button"
          T.tag "Chip", =>
            T.raw """
Bruce Banner
"""
            T.tag "Button", color: "clear", "aria-label": "Close", role: "button"
          T.tag "Chip", =>
            T.raw """
Steve Rogers
"""
            T.tag "Button", color: "clear", "aria-label": "Close", role: "button"
          T.tag "Chip", =>
            T.raw """
Tony Stark
"""
            T.tag "Button", color: "clear", "aria-label": "Close", role: "button"
          T.tag "Chip", =>
            T.raw """
Natasha
"""
            T.tag "Button", color: "clear", "aria-label": "Close", role: "button"
          T.tag "Chip", =>
            T.raw """
The batman
"""
            T.tag "Button", color: "clear", "aria-label": "Close", role: "button"
          T.div ".has-icon-left", =>
            T.tag "Input", size: "sm", placeholder: "Add user here", value: "S"
            T.tag "FormIcon", ".loading"
    T.raw """
));
"""
