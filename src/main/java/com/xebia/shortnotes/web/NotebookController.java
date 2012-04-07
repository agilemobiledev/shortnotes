package com.xebia.shortnotes.web;

import com.xebia.shortnotes.domain.Notebook;
import com.xebia.shortnotes.service.NoteService;

import java.math.BigInteger;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/notebooks")
@Controller
@RooWebScaffold(path = "notebooks", formBackingObject = Notebook.class)
public class NotebookController {
	
	@Autowired
	private NoteService noteService;

	@RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String update(@Valid Notebook notebook, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, notebook);
            return "notebooks/update";
        }
        uiModel.asMap().clear();
        notebookService.updateNotebook(notebook);
        noteService.updateNotesWithNoteBook(notebook);
        return "redirect:/notebooks/" + encodeUrlPathSegment(notebook.getId().toString(), httpServletRequest);
    }

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String delete(@PathVariable("id") BigInteger id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Notebook notebook = notebookService.findNotebook(id);
        noteService.removeNotes(notebook);
        notebookService.deleteNotebook(notebook);
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/notebooks";
    }
}
