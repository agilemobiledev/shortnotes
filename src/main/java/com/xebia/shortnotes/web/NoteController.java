package com.xebia.shortnotes.web;

import com.xebia.shortnotes.domain.Note;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/notes")
@Controller
@RooWebScaffold(path = "notes", formBackingObject = Note.class)
public class NoteController {
}
